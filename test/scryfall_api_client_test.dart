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
        final has_more = false;
        final id = 'b314f553-8f07-4ba9-96c8-16be7784eff3';
        final code = 'unf';
        final tcgplayer_id = 2958;
        final name = 'Unfinity';
        final uri_str =
            'https://api.scryfall.com/sets/b314f553-8f07-4ba9-96c8-16be7784eff3';
        final scryfall_uri_str = 'https://scryfall.com/sets/unf';
        final search_uri_str =
            'https://api.scryfall.com/cards/search?order=set&q=e%3Aunf&unique=prints';
        final released_at_str = '2022-04-01';
        final set_type_str = 'funny';
        final card_count = 26;
        final digital = false;
        final nonfoil_only = false;
        final foil_only = false;
        final icon_svg_uri_str =
            'https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1640581200';

        final json = jsonEncode({
          'object': 'list',
          'has_more': has_more,
          'data': [
            {
              'object': 'set',
              'id': id,
              'code': code,
              'tcgplayer_id': tcgplayer_id,
              'name': name,
              'uri': uri_str,
              'scryfall_uri': scryfall_uri_str,
              'search_uri': search_uri_str,
              'released_at': released_at_str,
              'set_type': set_type_str,
              'card_count': card_count,
              'digital': digital,
              'nonfoil_only': nonfoil_only,
              'foil_only': foil_only,
              'icon_svg_uri': icon_svg_uri_str,
            }
          ],
        });

        final uri = Uri.parse(uri_str);
        final scryfall_uri = Uri.parse(scryfall_uri_str);
        final search_uri = Uri.parse(search_uri_str);
        final released_at = DateTime.parse(released_at_str);
        final set_type = SetType.funny;
        final icon_svg_uri = Uri.parse(icon_svg_uri_str);

        final reponse = MockResponse();
        when(() => reponse.statusCode).thenReturn(200);
        when(() => reponse.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => reponse);
        final actual = await scryfallApiClient.getAllSets();
        expect(
          actual,
          isA<PaginableList>()
              .having((l) => l.hasMore, 'hasMore', false)
              .having((l) => l.length, 'length', 1)
              .having(
                (l) => l.data,
                'data',
                isA<List<MtgSet>>().having(
                  (l) => l.first,
                  'first',
                  isA<MtgSet>()
                      .having((s) => s.id, 'id', id)
                      .having((s) => s.code, 'code', code)
                      .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayer_id)
                      .having((s) => s.name, 'name', name)
                      .having((s) => s.uri, 'uri', uri)
                      .having((s) => s.scryfallUri, 'scryfallUri', scryfall_uri)
                      .having((s) => s.searchUri, 'searchUri', search_uri)
                      .having((s) => s.releasedAt, 'releasedAt', released_at)
                      .having((s) => s.setType, 'setType', set_type)
                      .having((s) => s.cardCount, 'cardCount', card_count)
                      .having((s) => s.digital, 'digital', digital)
                      .having((s) => s.nonfoilOnly, 'nonfoilOnly', nonfoil_only)
                      .having((s) => s.foilOnly, 'foilOnly', foil_only)
                      .having((s) => s.iconSvgUri, 'iconSvgUri', icon_svg_uri),
                ),
              ),
        );
      });

      test('gets valid reponse from actual server', () async {
        scryfallApiClient = ScryfallApiClient();
        final actual = await scryfallApiClient.getAllSets();
        expect(actual, isA<PaginableList<MtgSet>>());
      });
    });

    group('getSetByCode', () {
      final id = '385e11a4-492b-4d07-b4a6-a1409ef829b8';
      final code = 'mmq';
      final mtgo_code = 'mm';
      final arena_code = 'mm';
      final tcgplayer_id = 73;
      final name = 'Mercadian Masques';
      final uri_str =
          'https://api.scryfall.com/sets/385e11a4-492b-4d07-b4a6-a1409ef829b8';
      final scryfall_uri_str = 'https://scryfall.com/sets/mmq';
      final search_uri_str =
          'https://api.scryfall.com/cards/search?order=set&q=e%3Ammq&unique=prints';
      final released_at_str = '1999-10-04';
      final set_type_str = 'expansion';
      final card_count = 350;
      final printed_size = 350;
      final digital = false;
      final nonfoil_only = false;
      final foil_only = false;
      final block_code = 'mmq';
      final block = 'Masques';
      final icon_svg_uri_str =
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
          'mtgo_code': mtgo_code,
          'arena_code': arena_code,
          'tcgplayer_id': tcgplayer_id,
          'name': name,
          'uri': uri_str,
          'scryfall_uri': scryfall_uri_str,
          'search_uri': search_uri_str,
          'released_at': released_at_str,
          'set_type': set_type_str,
          'card_count': card_count,
          'printed_size': printed_size,
          'digital': digital,
          'nonfoil_only': nonfoil_only,
          'foil_only': foil_only,
          'block_code': block_code,
          'block': block,
          'icon_svg_uri': icon_svg_uri_str,
        });

        final uri = Uri.parse(uri_str);
        final scryfall_uri = Uri.parse(scryfall_uri_str);
        final search_uri = Uri.parse(search_uri_str);
        final released_at = DateTime.parse(released_at_str);
        final set_type = SetType.expansion;
        final icon_svg_uri = Uri.parse(icon_svg_uri_str);

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
              .having((s) => s.mtgoCode, 'mtgoCode', mtgo_code)
              .having((s) => s.arenaCode, 'arenaCode', arena_code)
              .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayer_id)
              .having((s) => s.name, 'name', name)
              .having((s) => s.uri, 'uri', uri)
              .having((s) => s.scryfallUri, 'scryfallUri', scryfall_uri)
              .having((s) => s.searchUri, 'searchUri', search_uri)
              .having((s) => s.releasedAt, 'releasedAt', released_at)
              .having((s) => s.setType, 'setType', set_type)
              .having((s) => s.cardCount, 'cardCount', card_count)
              .having((s) => s.printedSize, 'printedSize', printed_size)
              .having((s) => s.digital, 'digital', digital)
              .having((s) => s.nonfoilOnly, 'nonfoilOnly', nonfoil_only)
              .having((s) => s.foilOnly, 'foilOnly', foil_only)
              .having((s) => s.blockCode, 'blockCode', block_code)
              .having((s) => s.block, 'block', block)
              .having((s) => s.iconSvgUri, 'iconSvgUri', icon_svg_uri),
        );
      });

      test('gets valid response from actual server', () async {
        scryfallApiClient = ScryfallApiClient();
        final actual = await scryfallApiClient.getSetByCode(code);
        expect(actual, isA<MtgSet>());
      });
    });

    group('getSetByTcgplayerId', () {
      final object = 'set';
      final id = 'c26402e7-838e-48db-a4b2-7abfc305998a';
      final code = 'mp2';
      final mtgo_code = 'ms3';
      final arena_code = 'ms3';
      final tcgplayer_id = 1909;
      final name = 'Amonkhet Invocations';
      final uri_str =
          'https://api.scryfall.com/sets/c26402e7-838e-48db-a4b2-7abfc305998a';
      final scryfall_uri_str = 'https://scryfall.com/sets/mp2';
      final search_uri_str =
          'https://api.scryfall.com/cards/search?order=set&q=e%3Amp2&unique=prints';
      final released_at_str = '2017-04-28';
      final set_type_str = 'masterpiece';
      final card_count = 54;
      final parent_set_code = 'akh';
      final digital = false;
      final nonfoil_only = false;
      final foil_only = true;
      final block_code = 'akh';
      final block = 'Amonkhet';
      final icon_svg_uri_str =
          'https://c2.scryfall.com/file/scryfall-symbols/sets/mp2.svg?1640581200';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await scryfallApiClient.getSetByTcgplayerId(tcgplayer_id);
        } catch (_) {}
        verify(
          () => httpClient.get(Uri.https(
            'api.scryfall.com',
            '/sets/tcgplayer/$tcgplayer_id',
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
          scryfallApiClient.getSetByTcgplayerId(tcgplayer_id),
          throwsA(isA<ScryfallException>()),
        );
      });

      test('returns MtgSet on valid response', () async {
        final json = jsonEncode({
          "id": id,
          "code": code,
          "mtgo_code": mtgo_code,
          "arena_code": arena_code,
          "tcgplayer_id": tcgplayer_id,
          "name": name,
          "uri": uri_str,
          "scryfall_uri": scryfall_uri_str,
          "search_uri": search_uri_str,
          "released_at": released_at_str,
          "set_type": set_type_str,
          "card_count": card_count,
          "parent_set_code": parent_set_code,
          "digital": digital,
          "nonfoil_only": nonfoil_only,
          "foil_only": foil_only,
          "block_code": block_code,
          "block": block,
          "icon_svg_uri": icon_svg_uri_str,
        });

        final uri = Uri.parse(uri_str);
        final scryfall_uri = Uri.parse(scryfall_uri_str);
        final search_uri = Uri.parse(search_uri_str);
        final released_at = DateTime.parse(released_at_str);
        final set_type = SetType.masterpiece;
        final icon_svg_uri = Uri.parse(icon_svg_uri_str);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.getSetByTcgplayerId(
          tcgplayer_id,
        );
        expect(
          actual,
          isA<MtgSet>()
              .having((s) => s.id, 'id', id)
              .having((s) => s.code, 'code', code)
              .having((s) => s.mtgoCode, 'mtgoCode', mtgo_code)
              .having((s) => s.arenaCode, 'arenaCode', arena_code)
              .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayer_id)
              .having((s) => s.name, 'name', name)
              .having((s) => s.uri, 'uri', uri)
              .having((s) => s.scryfallUri, 'scryfallUri', scryfall_uri)
              .having((s) => s.searchUri, 'searchUri', search_uri)
              .having((s) => s.releasedAt, 'releasedAt', released_at)
              .having((s) => s.setType, 'setType', SetType.masterpiece)
              .having((s) => s.cardCount, 'cardCount', card_count)
              .having((s) => s.digital, 'digital', digital)
              .having((s) => s.nonfoilOnly, 'nonfoilOnly', nonfoil_only)
              .having((s) => s.foilOnly, 'foilOnly', foil_only)
              .having((s) => s.blockCode, 'blockCode', block_code)
              .having((s) => s.block, 'block', block)
              .having((s) => s.iconSvgUri, 'iconSvgUri', icon_svg_uri),
        );
      });

      test('gets valid response from actual server', () async {
        scryfallApiClient = ScryfallApiClient();
        final actual = await scryfallApiClient.getSetByTcgplayerId(
          tcgplayer_id,
        );
        expect(actual, isA<MtgSet>());
      });
    });
  });
}
