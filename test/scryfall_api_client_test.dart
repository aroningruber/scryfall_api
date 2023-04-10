import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:scryfall_api/scryfall_api.dart';
import 'package:scryfall_api/src/models/migration.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('ScryfallApiClient', () {
    late http.Client httpClient;
    late ScryfallApiClient scryfallApiClient;
    late ScryfallApiClient scryfallApiClientReal;
    late String jsonError;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      scryfallApiClient = ScryfallApiClient(httpClient: httpClient);
      scryfallApiClientReal = ScryfallApiClient();
      jsonError = jsonEncode({
        'object': 'error',
        'code': 'not_found',
        'status': 404,
        'details': 'Card not found.',
      });
    });

    tearDown(() {
      scryfallApiClient.close();
      scryfallApiClientReal.close();
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(ScryfallApiClient(), isNotNull);
      });
    });

    group('close', () {
      test('invalidates client; subsequent use results in ClientException',
          () async {
        scryfallApiClientReal.close();
        expect(
          scryfallApiClientReal.getAllSets(),
          throwsA(isA<http.ClientException>()),
        );
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final actual = await scryfallApiClientReal.getCardByNameAsImage(
          nameExact,
          set: set,
        );
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final actual = await scryfallApiClientReal.getRandomCardAsImage();
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
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
        final actual = await scryfallApiClientReal
            .getCardBySetCodeAndCollectorNumberAsImage(
          setCode,
          collectorNumber,
        );
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardBySetCodeAndCollectorNumberAsImage(
          setCode,
          collectorNumber,
        );
      });
    });

    group('getCardByMultiverseId', () {
      final multiverseId = 409574;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByMultiverseId(multiverseId);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/cards/multiverse/$multiverseId',
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByMultiverseId(multiverseId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_card_by_multiverse_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getCardByMultiverseId(multiverseId);
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getCardByMultiverseId(multiverseId);
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardByMultiverseIdAsImage', () {
      final multiverseId = 39526;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByMultiverseIdAsImage(
            multiverseId,
            backFace: false,
            imageVersion: ImageVersion.normal,
          );
        } catch (_) {}
        final uri =
            Uri.https('api.scryfall.com', '/cards/multiverse/$multiverseId', {
          'format': 'image',
          'version': 'normal',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByMultiverseIdAsImage(multiverseId),
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
            await scryfallApiClient.getCardByMultiverseIdAsImage(multiverseId);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal
            .getCardByMultiverseIdAsImage(multiverseId);
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardByMultiverseIdAsImage(multiverseId);
      });
    });

    group('getCardByMtgoId', () {
      final mtgoId = 54957;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByMtgoId(mtgoId);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/mtgo/$mtgoId');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByMtgoId(mtgoId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_card_by_mtgo_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardByMtgoId(mtgoId);
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getCardByMtgoId(mtgoId);
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardByMtgoIdAsImage', () {
      final mtgoId = 54957;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByMtgoIdAsImage(
            mtgoId,
            backFace: true,
            imageVersion: ImageVersion.large,
          );
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/mtgo/$mtgoId', {
          'format': 'image',
          'face': 'back',
          'version': 'large',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByMtgoIdAsImage(mtgoId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardByMtgoIdAsImage(mtgoId);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getCardByMtgoIdAsImage(mtgoId);
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardByMtgoIdAsImage(mtgoId);
      });
    });

    group('getCardByArenaId', () {
      final arenaId = 67330;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByArenaId(arenaId);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/arena/$arenaId');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByArenaId(arenaId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_card_by_arena_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardByArenaId(arenaId);
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getCardByArenaId(arenaId);
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardByArenaIdAsImage', () {
      final arenaId = 70665;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByArenaIdAsImage(
            arenaId,
            backFace: true,
            imageVersion: ImageVersion.large,
          );
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/arena/$arenaId', {
          'format': 'image',
          'face': 'back',
          'version': 'large',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByArenaIdAsImage(arenaId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardByArenaIdAsImage(arenaId);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getCardByArenaIdAsImage(arenaId);
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardByArenaIdAsImage(arenaId);
      });
    });

    group('getCardByTcgplayerId', () {
      final tcgplayerId = 67330;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByTcgplayerId(tcgplayerId);
        } catch (_) {}
        final uri =
            Uri.https('api.scryfall.com', '/cards/tcgplayer/$tcgplayerId');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByTcgplayerId(tcgplayerId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_card_by_tcgplayer_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getCardByTcgplayerId(tcgplayerId);
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getCardByTcgplayerId(tcgplayerId);
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardByTcgplayerIdAsImage', () {
      final tcgplayerId = 521;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByTcgplayerIdAsImage(
            tcgplayerId,
            backFace: true,
            imageVersion: ImageVersion.large,
          );
        } catch (_) {}
        final uri =
            Uri.https('api.scryfall.com', '/cards/tcgplayer/$tcgplayerId', {
          'format': 'image',
          'face': 'back',
          'version': 'large',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByTcgplayerIdAsImage(tcgplayerId),
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
            await scryfallApiClient.getCardByTcgplayerIdAsImage(tcgplayerId);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal
            .getCardByTcgplayerIdAsImage(tcgplayerId);
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardByTcgplayerIdAsImage(tcgplayerId);
      });
    });

    group('getCardByCardmarketId', () {
      final cardmarketId = 379041;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByCardmarketId(cardmarketId);
        } catch (_) {}
        final uri =
            Uri.https('api.scryfall.com', '/cards/cardmarket/$cardmarketId');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByCardmarketId(cardmarketId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_card_by_cardmarket_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getCardByCardmarketId(cardmarketId);
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getCardByCardmarketId(cardmarketId);
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardByCardmarketIdAsImage', () {
      final cardmarketId = 7800;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByCardmarketIdAsImage(
            cardmarketId,
            backFace: true,
            imageVersion: ImageVersion.large,
          );
        } catch (_) {}
        final uri =
            Uri.https('api.scryfall.com', '/cards/cardmarket/$cardmarketId', {
          'format': 'image',
          'face': 'back',
          'version': 'large',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByCardmarketIdAsImage(cardmarketId),
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
            await scryfallApiClient.getCardByCardmarketIdAsImage(cardmarketId);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal
            .getCardByCardmarketIdAsImage(cardmarketId);
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardByCardmarketIdAsImage(cardmarketId);
      });
    });

    group('getCardById', () {
      final id = 'e9d5aee0-5963-41db-a22b-cfea40a967a3';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardById(id);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/$id');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardById(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgCard on valid response', () async {
        final file = File('test/mock_data/get_card_by_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardById(id);
        expect(actual, isA<MtgCard>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getCardById(id);
        expect(actual, isA<MtgCard>());
      });
    });

    group('getCardByIdAsImage', () {
      final id = 'e7342875-d49b-4fa7-a2fb-8dfc5e3d6e4f';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getCardByIdAsImage(
            id,
            backFace: true,
            imageVersion: ImageVersion.large,
          );
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/$id', {
          'format': 'image',
          'face': 'back',
          'version': 'large',
        });
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCardByIdAsImage(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getCardByIdAsImage(id);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getCardByIdAsImage(id);
        expect(actual, isA<Uint8List>());
      });

      test('gets an image from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.get(invocation.positionalArguments[0]);
          expect(response.headers['content-type'], contains('image'));
          return response;
        });
        await scryfallApiClient.getCardByIdAsImage(id);
      });
    });

    group('getRulingByMultiverseId', () {
      final multiverseId = 3255;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getRulingsByMultiverseId(multiverseId);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/cards/multiverse/$multiverseId/rulings',
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getRulingsByMultiverseId(multiverseId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<Ruling> on valid response', () async {
        final file = File('test/mock_data/get_rulings_by_multiverse_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getRulingsByMultiverseId(multiverseId);
        expect(actual, isA<PaginableList<Ruling>>());
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getRulingsByMultiverseId(multiverseId);
        expect(actual, isA<PaginableList<Ruling>>());
      });
    });

    group('getRulingsByMtgoId', () {
      final mtgoId = 57934;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getRulingsByMtgoId(mtgoId);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/cards/mtgo/$mtgoId/rulings',
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getRulingsByMtgoId(mtgoId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<Ruling> on valid response', () async {
        final file = File('test/mock_data/get_rulings_by_mtgo_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getRulingsByMtgoId(mtgoId);
        expect(actual, isA<PaginableList<Ruling>>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getRulingsByMtgoId(mtgoId);
        expect(actual, isA<PaginableList<Ruling>>());
      });
    });

    group('getRulingsByArenaId', () {
      final arenaId = 67462;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getRulingsByArenaId(arenaId);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/cards/arena/$arenaId/rulings',
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getRulingsByArenaId(arenaId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<Ruling> on valid response', () async {
        final file = File('test/mock_data/get_rulings_by_arena_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getRulingsByArenaId(arenaId);
        expect(actual, isA<PaginableList<Ruling>>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getRulingsByArenaId(arenaId);
        expect(actual, isA<PaginableList<Ruling>>());
      });
    });

    group('getRulingsBySetCodeAndCollectorNumberId', () {
      final setCode = 'ima';
      final collectorNumber = '65';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getRulingsBySetCodeAndCollectorNumber(
            setCode,
            collectorNumber,
          );
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/cards/$setCode/$collectorNumber/rulings',
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getRulingsBySetCodeAndCollectorNumber(
            setCode,
            collectorNumber,
          ),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<Ruling> on valid response', () async {
        final file = File(
            'test/mock_data/get_rulings_by_set_code_and_collector_number.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getRulingsBySetCodeAndCollectorNumber(
          setCode,
          collectorNumber,
        );
        expect(actual, isA<PaginableList<Ruling>>());
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getRulingsBySetCodeAndCollectorNumber(
          setCode,
          collectorNumber,
        );
        expect(actual, isA<PaginableList<Ruling>>());
      });
    });

    group('getRulingsById', () {
      final id = 'f2b9983e-20d4-4d12-9e2c-ec6d9a345787';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getRulingsById(id);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/cards/$id/rulings');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getRulingsById(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<Ruling> on valid response', () async {
        final file = File('test/mock_data/get_rulings_by_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getRulingsById(id);
        expect(actual, isA<PaginableList<Ruling>>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getRulingsById(id);
        expect(actual, isA<PaginableList<Ruling>>());
      });
    });

    group('getAllCardSymbols', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getAllCardSymbols();
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/symbology');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getAllCardSymbols(),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<CardSymbol> on valid response', () async {
        final file = File('test/mock_data/get_all_card_symbols.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getAllCardSymbols();
        expect(actual, isA<PaginableList<CardSymbol>>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getAllCardSymbols();
        expect(actual, isA<PaginableList<CardSymbol>>());
      });
    });

    group('parseMana', () {
      final manaCost = '2g2';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.parseMana(manaCost);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/symbology/parse-mana',
          {'cost': manaCost},
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.parseMana(manaCost),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns ManaCost on valid response', () async {
        final file = File('test/mock_data/parse_mana.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.parseMana(manaCost);
        expect(actual, isA<ManaCost>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.parseMana(manaCost);
        expect(actual, isA<ManaCost>());
      });
    });

    group('getCatalog', () {
      test('makes correct http requests', () async {
        Future<void> testCategoryType(
          CatalogType catalogType,
          String expected,
        ) async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('{}');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          try {
            await scryfallApiClient.getCatalog(catalogType);
          } catch (_) {}
          final uri = Uri.https('api.scryfall.com', '/catalog/$expected');
          verify(() => httpClient.get(uri)).called(1);
        }

        await testCategoryType(CatalogType.cardNames, 'card-names');
        await testCategoryType(CatalogType.artistNames, 'artist-names');
        await testCategoryType(CatalogType.wordBank, 'word-bank');
        await testCategoryType(CatalogType.creatureTypes, 'creature-types');
        await testCategoryType(
            CatalogType.planeswalkerTypes, 'planeswalker-types');
        await testCategoryType(CatalogType.landTypes, 'land-types');
        await testCategoryType(CatalogType.artifactTypes, 'artifact-types');
        await testCategoryType(
            CatalogType.enchantmentTypes, 'enchantment-types');
        await testCategoryType(CatalogType.spellTypes, 'spell-types');
        await testCategoryType(CatalogType.powers, 'powers');
        await testCategoryType(CatalogType.toughnesses, 'toughnesses');
        await testCategoryType(CatalogType.loyalties, 'loyalties');
        await testCategoryType(CatalogType.watermarks, 'watermarks');
        await testCategoryType(
            CatalogType.keywordAbilities, 'keyword-abilities');
        await testCategoryType(CatalogType.keywordActions, 'keyword-actions');
        await testCategoryType(CatalogType.abilityWords, 'ability-words');
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getCatalog(CatalogType.cardNames),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Catalog on valid response', () async {
        final file = File('test/mock_data/get_catalog.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getCatalog(CatalogType.landTypes);
        expect(actual, isA<Catalog>());
      });

      test('gets valid response from actual server', () async {
        final actual =
            await scryfallApiClientReal.getCatalog(CatalogType.powers);
        expect(actual, isA<Catalog>());
      });
    });

    group('getCatalog convenience methods:', () {
      setUp(() {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
      });

      Future<void> testCatalogConvenienceMethod(
        Function method,
        String expected,
      ) async {
        try {
          await method();
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/catalog/$expected');
        verify(() => httpClient.get(uri)).called(1);
      }

      test('getCardNames called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getCardNames,
          'card-names',
        );
      });

      test('getArtistNames called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getArtistNames,
          'artist-names',
        );
      });

      test('getWordBank called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getWordBank,
          'word-bank',
        );
      });

      test('getCreatureTypes called getCatalog with correct argument',
          () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getCreatureTypes,
          'creature-types',
        );
      });

      test('getPlaneswalkerTypes called getCatalog with correct argument',
          () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getPlaneswalkerTypes,
          'planeswalker-types',
        );
      });

      test('getLandTypes called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getLandTypes,
          'land-types',
        );
      });

      test('getArtifactTypes called getCatalog with correct argument',
          () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getArtifactTypes,
          'artifact-types',
        );
      });

      test('getEnchantmentTypes called getCatalog with correct argument',
          () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getEnchantmentTypes,
          'enchantment-types',
        );
      });

      test('getSpellTypes called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getSpellTypes,
          'spell-types',
        );
      });

      test('getPowers called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getPowers,
          'powers',
        );
      });

      test('getToughnesses called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getToughnesses,
          'toughnesses',
        );
      });

      test('getLoyalties called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getLoyalties,
          'loyalties',
        );
      });

      test('getWatermarks called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getWatermarks,
          'watermarks',
        );
      });

      test('getKeywordAbilities called getCatalog with correct argument',
          () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getKeywordAbilities,
          'keyword-abilities',
        );
      });

      test('getKeywordActions called getCatalog with correct argument',
          () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getKeywordActions,
          'keyword-actions',
        );
      });

      test('getAbilityWords called getCatalog with correct argument', () async {
        testCatalogConvenienceMethod(
          scryfallApiClient.getAbilityWords,
          'ability-words',
        );
      });
    });

    group('getBulkData', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getBulkData();
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/bulk-data');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getBulkData(),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns PaginableList<BulkData> on valid response', () async {
        final file = File('test/mock_data/get_bulk_data.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getBulkData();
        expect(actual, isA<PaginableList<BulkData>>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getBulkData();
        expect(actual, isA<PaginableList<BulkData>>());
      });
    });

    group('getBulkDataById', () {
      const id = '922288cb-4bef-45e1-bb30-0c2bd3d3534f';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getBulkDataById(id);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/bulk-data/$id');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getBulkDataById(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns BulkData on valid response', () async {
        final file = File('test/mock_data/get_bulk_data_by_id.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getBulkDataById(id);
        expect(actual, isA<BulkData>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getBulkDataById(id);
        expect(actual, isA<BulkData>());
      });
    });

    group('getBulkdDataByIdAsFile', () {
      const id = '06f54c0b-ab9c-452d-b35a-8297db5eb940';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getBulkDataByIdAsFile(id);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/bulk-data/$id',
          {'format': 'file'},
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getBulkDataByIdAsFile(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getBulkDataByIdAsFile(id);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.head(invocation.positionalArguments[0]);
          expect(response.statusCode, 200);
          return response;
        });
        await scryfallApiClient.getBulkDataByIdAsFile(id);
      });
    });

    group('getBulkDataByType', () {
      test('makes correct http requests', () async {
        Future<void> testBulkDataType(
          BulkDataType bulkDataType,
          String expected,
        ) async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('{}');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          try {
            await scryfallApiClient.getBulkDataByType(bulkDataType);
          } catch (_) {}
          final uri = Uri.https('api.scryfall.com', '/bulk-data/$expected');
          verify(() => httpClient.get(uri)).called(1);
        }

        await testBulkDataType(BulkDataType.oracleCards, 'oracle-cards');
        await testBulkDataType(BulkDataType.uniqueArtwork, 'unique-artwork');
        await testBulkDataType(BulkDataType.defaultCards, 'default-cards');
        await testBulkDataType(BulkDataType.allCards, 'all-cards');
        await testBulkDataType(BulkDataType.rulings, 'rulings');
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getBulkDataByType(BulkDataType.allCards),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns BulkData on valid response', () async {
        final file = File('test/mock_data/get_bulk_data_by_type.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual =
            await scryfallApiClient.getBulkDataByType(BulkDataType.oracleCards);
        expect(actual, isA<BulkData>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal
            .getBulkDataByType(BulkDataType.uniqueArtwork);
        expect(actual, isA<BulkData>());
      });
    });

    group('getBulkDataByTypeAsFile', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List(0));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient
              .getBulkDataByTypeAsFile(BulkDataType.allCards);
        } catch (_) {}
        final uri = Uri.https(
          'api.scryfall.com',
          '/bulk-data/all-cards',
          {'format': 'file'},
        );
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getBulkDataByTypeAsFile(BulkDataType.oracleCards),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Uint8List on valid response', () async {
        final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(bytes);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient
            .getBulkDataByTypeAsFile(BulkDataType.uniqueArtwork);
        expect(actual, isA<Uint8List>().having((l) => l.length, 'length', 5));
      });

      test('gets valid response from actual server', () async {
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final response = await http.head(invocation.positionalArguments[0]);
          expect(response.statusCode, 200);
          return response;
        });
        await scryfallApiClient.getBulkDataByTypeAsFile(BulkDataType.allCards);
      });
    });

    group('getBulkDataByTypeAsFile convenience methods', () {
      setUp(() {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes)
            .thenReturn(Uint8List.fromList(utf8.encode('[]')));
        when(() => httpClient.get(any())).thenAnswer((invocation) async {
          final responseHead =
              await http.head(invocation.positionalArguments[0]);
          expect(responseHead.statusCode, 200);
          return response;
        });
      });

      test('getBulkDataOracleCards makes correct request', () async {
        final actual = await scryfallApiClient.getBulkDataOracleCards();
        expect(actual, isA<List<MtgCard>>());
      });

      test(
        'getBulkDataOracleCards properly decodes response from actual server',
        () async {
          final actual = await scryfallApiClientReal.getBulkDataOracleCards();
          expect(actual, isA<List<MtgCard>>());
        },
      );

      test('getBulkDataUniqueArtwork', () async {
        final actual = await scryfallApiClient.getBulkDataUniqueArtwork();
        expect(actual, isA<List<MtgCard>>());
      });

      test('getBulkDataDefaultCards makes correct request', () async {
        final actual = await scryfallApiClient.getBulkDataDefaultCards();
        expect(actual, isA<List<MtgCard>>());
      });

      test('getBulkDataAllCards makes correct request', () async {
        final actual = await scryfallApiClient.getBulkDataAllCards();
        expect(actual, isA<List<MtgCard>>());
      });

      test('getBulkDataRulings', () async {
        final actual = await scryfallApiClient.getBulkDataRulings();
        expect(actual, isA<List<Ruling>>());
      });

      test(
        'getBulkDataRulings properly decodes response from actual server',
        () async {
          final actual = await scryfallApiClientReal.getBulkDataRulings();
          expect(actual, isA<List<Ruling>>());
        },
      );
    });

    group('getMigrations', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getMigrations();
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/migrations');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getMigrations(),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Migrations on valid response', () async {
        final file = File('test/mock_data/get_migrations.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getMigrations();
        expect(actual, isA<PaginableList<Migration>>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getMigrations();
        expect(actual, isA<PaginableList<Migration>>());
      });
    });

    group('getMigration', () {
      final id = '8a28f61a-16b8-47f9-8818-fd4e1f2d9b79';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getMigration(id);
        } catch (_) {}
        final uri = Uri.https('api.scryfall.com', '/migrations/$id');
        verify(() => httpClient.get(uri)).called(1);
      });

      test('throws ScryfallException on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn(jsonError);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          scryfallApiClient.getMigration(id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns Migrations on valid response', () async {
        final file = File('test/mock_data/get_migration.json');
        final json = await file.readAsString();

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getMigration(id);
        expect(actual, isA<Migration>());
      });

      test('gets valid response from actual server', () async {
        final actual = await scryfallApiClientReal.getMigration(id);
        expect(actual, isA<Migration>());
      });
    });
  });
}
