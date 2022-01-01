import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Mock implements Uri {}

void main() {
  group('ScryfallApiClient', () {
    late http.Client httpClient;
    late ScryfallApiClient scryfallApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      scryfallApiClient = ScryfallApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(ScryfallApiClient(), isNotNull);
      });
    });

    group('getAllSets', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getAllSets();
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/sets');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'bad_request',
          'status': 400,
          'details': 'All of your terms were ignored.',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getAllSets(),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<MtgSet> on valid response', () async {
        final file = File('test/mock_data/get_all_sets.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getAllSets();
        expect(actual, isA<PaginableList>());
      });

      test('gets valid reponse from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getAllSets();
        expect(actual, isA<PaginableList<MtgSet>>());
      });
    });

    group('getSetByCode', () {
      final code = 'mmq';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getSetByCode(code);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/sets/$code');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'No Magic set found for the given code or ID',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getSetByCode(code),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgSet on valid response', () async {
        final file = File('test/mock_data/get_set_by_code.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getSetByCode(code);
        expect(actual, isA<MtgSet>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getSetByCode(code);
        expect(actual, isA<MtgSet>());
      });
    });

    group('getSetByTcgplayerId', () {
      final id = 1909;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getSetByTcgplayerId(id);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/sets/tcgplayer/$id',
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'No Magic set found for the given code or ID',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getSetByTcgplayerId(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgSet on valid response', () async {
        final file = File('test/mock_data/get_set_by_tcgplayer_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getSetByTcgplayerId(id);
        expect(actual, isA<MtgSet>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getSetByTcgplayerId(id);
        expect(actual, isA<MtgSet>());
      });
    });

    group('getSetById', () {
      final id = '2ec77b94-6d47-4891-a480-5d0b4e5c9372';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getSetById(id);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/sets/$id');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'No Magic set found for the given code or ID',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getSetById(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgSet on valid response', () async {
        final file = File('test/mock_data/get_set_by_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getSetById(id);
        expect(actual, isA<MtgSet>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getSetById(id);
        expect(actual, isA<MtgSet>());
      });
    });

    group('searchCards', () {
      final searchQuery = 'c:red pow=3';
      final sortingOrder = SortingOrder.cmc;

      test('makes correct http request', () async {
        final rollupMode = RollupMode.art;
        final sortingDirection = SortingDirection.descending;
        final includeExtras = false;
        final includeMultilingual = true;
        final includeVariations = true;
        final page = 2;

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.searchCards(
            searchQuery,
            rollupMode: rollupMode,
            sortingOrder: sortingOrder,
            sortingDirection: sortingDirection,
            includeExtras: includeExtras,
            includeMultilingual: includeMultilingual,
            includeVariations: includeVariations,
            page: page,
          );
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/search', {
          'q': searchQuery,
          'unique': rollupMode.name,
          'order': sortingOrder.name,
          'dir': 'desc',
          'include_extras': includeExtras.toString(),
          'include_multilingual': includeMultilingual.toString(),
          'include_variations': includeVariations.toString(),
          'page': page.toString(),
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'The requested object or REST method was not found.',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.searchCards(
            searchQuery,
            sortingOrder: sortingOrder,
          ),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<MtgCard> on valid response', () async {
        final file = File('test/mock_data/search_cards.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.searchCards(
          searchQuery,
          sortingOrder: sortingOrder,
        );
        expect(actual, isA<PaginableList>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.searchCards(
          searchQuery,
          sortingOrder: sortingOrder,
        );
        expect(actual, isA<PaginableList<MtgCard>>());
      });
    });

    group('getCardByName', () {
      final nameExact = 'Austere Command';
      final nameFuzzy = 'aust com';
      final set = 'cmr';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByName(nameExact, set: set);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/named', {
          'exact': nameExact,
          'set': set,
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'No cards found matching “aust com”',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByName(nameExact),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_card_by_name.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardByName(
          nameFuzzy,
          searchType: SearchType.fuzzy,
        );
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getCardByName(
          nameExact,
          set: set,
        );
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardByNameAsImage', () {
      final nameExact = 'Angelic Quartermaster';
      final nameFuzzy = 'angel quart';
      final set = 'vow';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByNameAsImage(
            nameExact,
            set: set,
            backFace: false,
            imageVersion: ImageVersion.borderCrop,
          );
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/named', {
          'format': 'image',
          'exact': nameExact,
          'set': set,
          'version': 'border_crop',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 reponse', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'No cards found matching “angel quart”',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByNameAsImage(nameExact),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardByNameAsImage(
          nameFuzzy,
          searchType: SearchType.fuzzy,
        );
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getCardByNameAsImage(
          nameExact,
          set: set,
        );
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.Client().get(
            invocation.positionalArguments[0],
          );
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        scryfallApiClient.getCardByNameAsImage(
          nameExact,
          set: set,
        );
      });
    });

    group('autocompleteCardName', () {
      final query = 'thal';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.autocompleteCardName(
            query,
            includeExtras: true,
          );
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/autocomplete', {
          'q': query,
          'include_extras': 'true',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'bad_request',
          'status': 400,
          'details': 'Something went wrong',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.autocompleteCardName(query),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Catalog on valid response', () async {
        final file = File('test/mock_data/autocomplete_card_name.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.autocompleteCardName(query);
        expect(actual, isA<Catalog>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.autocompleteCardName(query);
        expect(actual, isA<Catalog>());
      });
    });

    group('getRandomCard', () {
      final query = 'is:commander';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getRandomCard(query: query);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/random', {
          'q': query,
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details':
              '0 cards matched this search, a random card could not be returned.',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getRandomCard(query: query),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_random_card.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getRandomCard(query: query);
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getRandomCard(query: query);
        expect(actual, isA<MtgCard>());
      });
    });

    group('getRandomCardAsImage', () {
      final query = 'dragon';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getRandomCardAsImage(
            query: query,
            backFace: true,
            imageVersion: ImageVersion.artCrop,
          );
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/random', {
          'format': 'image',
          'q': query,
          'face': 'back',
          'version': 'art_crop',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details':
              '0 cards matched this search, a random card could not be returned.',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getRandomCardAsImage(),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getRandomCardAsImage();
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getRandomCardAsImage();
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.Client().get(
            invocation.positionalArguments[0],
          );
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        scryfallApiClient.getRandomCardAsImage();
      });
    });

    group('getCardsByIdentifiers', () {
      final id = '683a5707-cddb-494d-9b41-51b4584ded69';
      final name = 'Ancient Tomb';
      final set = 'mrd';
      final collectorNumber = '150';
      final identifiers = [
        CardIdentifierId(id),
        CardIdentifierName(name),
        CardIdentifierSetCollectorNumber(set, collectorNumber),
      ];

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardsByIdentifiers(identifiers);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/collection');
        final body = jsonEncode({
          'identifiers': [
            {'id': id},
            {'name': name},
            {'set': set, 'collector_number': collectorNumber},
          ],
        });
        final headers = {'Content-Type': 'application/json'};
        verify(() => httpClient.post(uri, body: body, headers: headers))
            .called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details':
              '0 cards matched this search, a random card could not be returned.',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expectLater(
          scryfallApiClient.getCardsByIdentifiers(identifiers),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns CardList on valid response', () async {
        final file = File('test/mock_data/get_cards_by_identifiers.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getCardsByIdentifiers(identifiers);
        expect(
          actual,
          isA<CardList>()
              .having((l) => l.data.length, 'data.length', 2)
              .having((l) => l.notFound.length, 'notFound.length', 1),
        );
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual =
            await scryfallApiClientReal.getCardsByIdentifiers(identifiers);
        expect(actual, isA<CardList>());
      });
    });

    group('getCardBySetCodeAndCollectorNumber', () {
      final setCode = 'xln';
      final collectorNumber = '96';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardBySetCodeAndCollectorNumber(
            setCode,
            collectorNumber,
            language: Language.japanese,
          );
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/cards/$setCode/$collectorNumber/ja',
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'Card not found.',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardBySetCodeAndCollectorNumber(
            setCode,
            collectorNumber,
          ),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File(
            'test/mock_data/get_card_by_set_code_and_collector_number.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getCardBySetCodeAndCollectorNumber(
          setCode,
          collectorNumber,
        );
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual =
            await scryfallApiClientReal.getCardBySetCodeAndCollectorNumber(
          setCode,
          collectorNumber,
        );
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardBySetCodeAndCollectorNumberAsImage', () {
      final setCode = 'mid';
      final collectorNumber = '17';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardBySetCodeAndCollectorNumberAsImage(
            setCode,
            collectorNumber,
            language: Language.russian,
            backFace: true,
            imageVersion: ImageVersion.small,
          );
        } catch (_) {}
        final uri = Uri.https(
            'api.scryfall.com', '/cards/$setCode/$collectorNumber/ru', {
          'format': 'image',
          'face': 'back',
          'version': 'small',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final json = jsonEncode({
          'object': 'error',
          'code': 'not_found',
          'status': 404,
          'details': 'No card found.',
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardBySetCodeAndCollectorNumberAsImage(
            setCode,
            collectorNumber,
          ),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getCardBySetCodeAndCollectorNumberAsImage(
          setCode,
          collectorNumber,
        );
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal
            .getCardBySetCodeAndCollectorNumberAsImage(
          setCode,
          collectorNumber,
        );
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.Client().get(
            invocation.positionalArguments[0],
          );
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardBySetCodeAndCollectorNumberAsImage(
          setCode,
          collectorNumber,
        );
      });
    });
  });
}
