import 'dart:convert';

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
        verify(
          () => httpClient.get(Uri.https('api.scryfall.com', '/sets')),
        ).called(1);
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
        final hasMore = false;
        final data = [
          {
            'object': 'set',
            'id': 'b314f553-8f07-4ba9-96c8-16be7784eff3',
            'code': 'unf',
            'tcgplayer_id': 2958,
            'name': 'Unfinity',
            'uri':
                'https://api.scryfall.com/sets/b314f553-8f07-4ba9-96c8-16be7784eff3',
            'scryfall_uri': 'https://scryfall.com/sets/unf',
            'search_uri':
                'https://api.scryfall.com/cards/search?order=set&q=e%3Aunf&unique=prints',
            'released_at': '2022-04-01',
            'set_type': 'funny',
            'card_count': 26,
            'digital': false,
            'nonfoil_only': false,
            'foil_only': false,
            'icon_svg_uri':
                'https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1640581200',
          },
        ];

        final json = jsonEncode({
          'object': 'list',
          'has_more': hasMore,
          'data': data,
        });

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getAllSets();
        expect(
          actual,
          isA<PaginableList>()
              .having((l) => l.hasMore, 'hasMore', hasMore)
              .having((l) => l.length, 'length', data.length)
              .having(
                (l) => l.data,
                'data',
                isA<List<MtgSet>>().having(
                  (l) => l.first,
                  'first',
                  isA<MtgSet>(),
                ),
              ),
        );
      });

      test('gets valid reponse from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getAllSets();
        expect(actual, isA<PaginableList<MtgSet>>());
      });
    });

    group('getSetByCode', () {
      final id = '385e11a4-492b-4d07-b4a6-a1409ef829b8';
      final code = 'mmq';
      final mtgoCode = 'mm';
      final arenaCode = 'mm';
      final tcgplayerId = 73;
      final name = 'Mercadian Masques';
      final uriStr =
          'https://api.scryfall.com/sets/385e11a4-492b-4d07-b4a6-a1409ef829b8';
      final scryfallUriStr = 'https://scryfall.com/sets/mmq';
      final searchUriStr =
          'https://api.scryfall.com/cards/search?order=set&q=e%3Ammq&unique=prints';
      final releasedAtStr = '1999-10-04';
      final setTypeStr = 'expansion';
      final cardCount = 350;
      final printedSize = 350;
      final digital = false;
      final nonfoilOnly = false;
      final foilOnly = false;
      final blockCode = 'mmq';
      final block = 'Masques';
      final iconSvgUriStr =
          'https://c2.scryfall.com/file/scryfall-symbols/sets/mmq.svg?1640581200';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getSetByCode(code);
        } catch (_) {}
        verify(
          () => httpClient.get(Uri.https(
            'api.scryfall.com',
            '/sets/$code',
          )),
        ).called(1);
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
        final json = jsonEncode({
          'object': 'set',
          'id': id,
          'code': code,
          'mtgo_code': mtgoCode,
          'arena_code': arenaCode,
          'tcgplayer_id': tcgplayerId,
          'name': name,
          'uri': uriStr,
          'scryfall_uri': scryfallUriStr,
          'search_uri': searchUriStr,
          'released_at': releasedAtStr,
          'set_type': setTypeStr,
          'card_count': cardCount,
          'printed_size': printedSize,
          'digital': digital,
          'nonfoil_only': nonfoilOnly,
          'foil_only': foilOnly,
          'block_code': blockCode,
          'block': block,
          'icon_svg_uri': iconSvgUriStr,
        });

        final uri = Uri.parse(uriStr);
        final scryfallUri = Uri.parse(scryfallUriStr);
        final searchUri = Uri.parse(searchUriStr);
        final releasedAt = DateTime.parse(releasedAtStr);
        final setType = SetType.expansion;
        final iconSvgUri = Uri.parse(iconSvgUriStr);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getSetByCode(code);
        expect(
          actual,
          isA<MtgSet>()
              .having((s) => s.id, 'id', id)
              .having((s) => s.code, 'code', code)
              .having((s) => s.mtgoCode, 'mtgoCode', mtgoCode)
              .having((s) => s.arenaCode, 'arenaCode', arenaCode)
              .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayerId)
              .having((s) => s.name, 'name', name)
              .having((s) => s.uri, 'uri', uri)
              .having((s) => s.scryfallUri, 'scryfallUri', scryfallUri)
              .having((s) => s.searchUri, 'searchUri', searchUri)
              .having((s) => s.releasedAt, 'releasedAt', releasedAt)
              .having((s) => s.setType, 'setType', setType)
              .having((s) => s.cardCount, 'cardCount', cardCount)
              .having((s) => s.printedSize, 'printedSize', printedSize)
              .having((s) => s.digital, 'digital', digital)
              .having((s) => s.nonfoilOnly, 'nonfoilOnly', nonfoilOnly)
              .having((s) => s.foilOnly, 'foilOnly', foilOnly)
              .having((s) => s.blockCode, 'blockCode', blockCode)
              .having((s) => s.block, 'block', block)
              .having((s) => s.iconSvgUri, 'iconSvgUri', iconSvgUri),
        );
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getSetByCode(code);
        expect(actual, isA<MtgSet>());
      });
    });

    group('getSetByTcgplayerId', () {
      final id = 'c26402e7-838e-48db-a4b2-7abfc305998a';
      final code = 'mp2';
      final mtgoCode = 'ms3';
      final arenaCode = 'ms3';
      final tcgplayerId = 1909;
      final name = 'Amonkhet Invocations';
      final uriStr =
          'https://api.scryfall.com/sets/c26402e7-838e-48db-a4b2-7abfc305998a';
      final scryfallUriStr = 'https://scryfall.com/sets/mp2';
      final searchUriStr =
          'https://api.scryfall.com/cards/search?order=set&q=e%3Amp2&unique=prints';
      final releasedAtStr = '2017-04-28';
      final setTypeStr = 'masterpiece';
      final cardCount = 54;
      final parentSetCode = 'akh';
      final digital = false;
      final nonfoilOnly = false;
      final foilOnly = true;
      final blockCode = 'akh';
      final block = 'Amonkhet';
      final iconSvgUriStr =
          'https://c2.scryfall.com/file/scryfall-symbols/sets/mp2.svg?1640581200';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getSetByTcgplayerId(tcgplayerId);
        } catch (_) {}
        verify(
          () => httpClient.get(Uri.https(
            'api.scryfall.com',
            '/sets/tcgplayer/$tcgplayerId',
          )),
        ).called(1);
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
          scryfallApiClient.getSetByTcgplayerId(tcgplayerId),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgSet on valid response', () async {
        final json = jsonEncode({
          'object': 'set',
          'id': id,
          'code': code,
          'mtgo_code': mtgoCode,
          'arena_code': arenaCode,
          'tcgplayer_id': tcgplayerId,
          'name': name,
          'uri': uriStr,
          'scryfall_uri': scryfallUriStr,
          'search_uri': searchUriStr,
          'released_at': releasedAtStr,
          'set_type': setTypeStr,
          'card_count': cardCount,
          'parent_set_code': parentSetCode,
          'digital': digital,
          'nonfoil_only': nonfoilOnly,
          'foil_only': foilOnly,
          'block_code': blockCode,
          'block': block,
          'icon_svg_uri': iconSvgUriStr,
        });

        final uri = Uri.parse(uriStr);
        final scryfallUri = Uri.parse(scryfallUriStr);
        final searchUri = Uri.parse(searchUriStr);
        final releasedAt = DateTime.parse(releasedAtStr);
        final setType = SetType.masterpiece;
        final iconSvgUri = Uri.parse(iconSvgUriStr);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getSetByTcgplayerId(
          tcgplayerId,
        );
        expect(
          actual,
          isA<MtgSet>()
              .having((s) => s.id, 'id', id)
              .having((s) => s.code, 'code', code)
              .having((s) => s.mtgoCode, 'mtgoCode', mtgoCode)
              .having((s) => s.arenaCode, 'arenaCode', arenaCode)
              .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayerId)
              .having((s) => s.name, 'name', name)
              .having((s) => s.uri, 'uri', uri)
              .having((s) => s.scryfallUri, 'scryfallUri', scryfallUri)
              .having((s) => s.searchUri, 'searchUri', searchUri)
              .having((s) => s.releasedAt, 'releasedAt', releasedAt)
              .having((s) => s.setType, 'setType', setType)
              .having((s) => s.cardCount, 'cardCount', cardCount)
              .having((s) => s.digital, 'digital', digital)
              .having((s) => s.nonfoilOnly, 'nonfoilOnly', nonfoilOnly)
              .having((s) => s.foilOnly, 'foilOnly', foilOnly)
              .having((s) => s.blockCode, 'blockCode', blockCode)
              .having((s) => s.block, 'block', block)
              .having((s) => s.iconSvgUri, 'iconSvgUri', iconSvgUri),
        );
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getSetByTcgplayerId(
          tcgplayerId,
        );
        expect(actual, isA<MtgSet>());
      });
    });

    group('getSetById', () {
      final id = '2ec77b94-6d47-4891-a480-5d0b4e5c9372';
      final code = 'uma';
      final mtgoCode = 'uma';
      final arenaCode = 'uma';
      final tcgplayerId = 2360;
      final name = 'Ultimate Masters';
      final uriStr =
          'https://api.scryfall.com/sets/2ec77b94-6d47-4891-a480-5d0b4e5c9372';
      final scryfallUriStr = 'https://scryfall.com/sets/uma';
      final searchUriStr =
          'https://api.scryfall.com/cards/search?order=set&q=e%3Auma&unique=prints';
      final releasedAtStr = '2018-12-07';
      final setTypeStr = 'masters';
      final cardCount = 254;
      final printedSize = 254;
      final digital = false;
      final nonfoilOnly = false;
      final foilOnly = false;
      final iconSvgUriStr =
          'https://c2.scryfall.com/file/scryfall-symbols/sets/uma.svg?1640581200';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getSetById(id);
        } catch (_) {}
        verify(
          () => httpClient.get(Uri.https(
            'api.scryfall.com',
            '/sets/$id',
          )),
        ).called(1);
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
        final json = jsonEncode({
          'object': 'set',
          'id': id,
          'code': code,
          'mtgo_code': mtgoCode,
          'arena_code': arenaCode,
          'tcgplayer_id': tcgplayerId,
          'name': name,
          'uri': uriStr,
          'scryfall_uri': scryfallUriStr,
          'search_uri': searchUriStr,
          'released_at': releasedAtStr,
          'set_type': setTypeStr,
          'card_count': cardCount,
          'printed_size': printedSize,
          'digital': digital,
          'nonfoil_only': nonfoilOnly,
          'foil_only': foilOnly,
          'icon_svg_uri': iconSvgUriStr,
        });

        final uri = Uri.parse(uriStr);
        final scryfallUri = Uri.parse(scryfallUriStr);
        final searchUri = Uri.parse(searchUriStr);
        final releasedAt = DateTime.parse(releasedAtStr);
        final setType = SetType.masters;
        final iconSvgUri = Uri.parse(iconSvgUriStr);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getSetById(id);
        expect(
          actual,
          isA<MtgSet>()
              .having((s) => s.id, 'id', id)
              .having((s) => s.code, 'code', code)
              .having((s) => s.mtgoCode, 'mtgoCode', mtgoCode)
              .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayerId)
              .having((s) => s.name, 'name', name)
              .having((s) => s.uri, 'uri', uri)
              .having((s) => s.scryfallUri, 'scryfallUri', scryfallUri)
              .having((s) => s.searchUri, 'searchUri', searchUri)
              .having((s) => s.releasedAt, 'releasedAt', releasedAt)
              .having((s) => s.setType, 'setType', setType)
              .having((s) => s.cardCount, 'cardCount', cardCount)
              .having((s) => s.printedSize, 'printedSize', printedSize)
              .having((s) => s.digital, 'digital', digital)
              .having((s) => s.nonfoilOnly, 'nonfoilOnly', nonfoilOnly)
              .having((s) => s.foilOnly, 'foilOnly', foilOnly)
              .having((s) => s.iconSvgUri, 'iconSvgUri', iconSvgUri),
        );
      });

      test('gets valid response from actual server', () async {
        final scryfallApiClientReal = ScryfallApiClient();
        final actual = await scryfallApiClientReal.getSetById(id);
        expect(actual, isA<MtgSet>());
      });
    });
  });
}
