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
  });
}
