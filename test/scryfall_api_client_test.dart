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
        final uri = Uri.https(
          'api.scryfall.com',
          '/sets/tcgplayer/$tcgplayerId',
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

    group('getCardsBySearch', () {
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
        final uri = Uri.https(
          'api.scryfall.com',
          '/cards/search',
          {
            'q': searchQuery,
            'unique': rollupMode.name,
            'order': sortingOrder.name,
            'dir': 'desc',
            'include_extras': includeExtras.toString(),
            'include_multilingual': includeMultilingual.toString(),
            'include_variations': includeVariations.toString(),
            'page': page.toString(),
          },
        );
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
        final totalCards = 566;
        final hasMore = true;
        final nextPageStr =
            'https://api.scryfall.com/cards/search?format=json&include_extras=false&include_multilingual=false&order=cmc&page=2&q=c%3Ared+pow%3D3&unique=cards';
        final data = [
          {
            'object': 'card',
            'id': 'd99a9a7d-d9ca-4c11-80ab-e39d5943a315',
            'oracle_id': '1f74e26f-5cf3-4b0e-bcc6-f858599474fc',
            'multiverse_ids': [522262],
            'mtgo_id': 90749,
            'tcgplayer_id': 239722,
            'cardmarket_id': 566268,
            'name': 'Asmoranomardicadaistinaculdacar',
            'lang': 'en',
            'released_at': '2021-06-18',
            'uri':
                'https://api.scryfall.com/cards/d99a9a7d-d9ca-4c11-80ab-e39d5943a315',
            'scryfall_uri':
                'https://scryfall.com/card/mh2/186/asmoranomardicadaistinaculdacar?utm_source=api',
            'layout': 'normal',
            'highres_image': true,
            'image_status': 'highres_scan',
            'image_uris': {
              'small':
                  'https://c1.scryfall.com/file/scryfall-cards/small/front/d/9/d99a9a7d-d9ca-4c11-80ab-e39d5943a315.jpg?1632831210',
              'normal':
                  'https://c1.scryfall.com/file/scryfall-cards/normal/front/d/9/d99a9a7d-d9ca-4c11-80ab-e39d5943a315.jpg?1632831210',
              'large':
                  'https://c1.scryfall.com/file/scryfall-cards/large/front/d/9/d99a9a7d-d9ca-4c11-80ab-e39d5943a315.jpg?1632831210',
              'png':
                  'https://c1.scryfall.com/file/scryfall-cards/png/front/d/9/d99a9a7d-d9ca-4c11-80ab-e39d5943a315.png?1632831210',
              'art_crop':
                  'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/d/9/d99a9a7d-d9ca-4c11-80ab-e39d5943a315.jpg?1632831210',
              'border_crop':
                  'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/d/9/d99a9a7d-d9ca-4c11-80ab-e39d5943a315.jpg?1632831210'
            },
            'mana_cost': '',
            'cmc': 0,
            'type_line': 'Legendary Creature — Human Wizard',
            'oracle_text':
                'As long as you\'ve discarded a card this turn, you may pay {B/R} to cast this spell.\nWhen Asmoranomardicadaistinaculdacar enters the battlefield, you may search your library for a card named The Underworld Cookbook, reveal it, put it into your hand, then shuffle.\nSacrifice two Foods: Target creature deals 6 damage to itself.',
            'power': '3',
            'toughness': '3',
            'colors': ['B', 'R'],
            'color_indicator': ['B', 'R'],
            'color_identity': ['B', 'R'],
            'keywords': [],
            'all_parts': [
              {
                'object': 'related_card',
                'id': 'd99a9a7d-d9ca-4c11-80ab-e39d5943a315',
                'component': 'combo_piece',
                'name': 'Asmoranomardicadaistinaculdacar',
                'type_line': 'Legendary Creature — Human Wizard',
                'uri':
                    'https://api.scryfall.com/cards/d99a9a7d-d9ca-4c11-80ab-e39d5943a315'
              },
              {
                'object': 'related_card',
                'id': '039d62b0-3309-4424-a2ea-5a0d88d4bd72',
                'component': 'combo_piece',
                'name': 'The Underworld Cookbook',
                'type_line': 'Artifact',
                'uri':
                    'https://api.scryfall.com/cards/039d62b0-3309-4424-a2ea-5a0d88d4bd72'
              }
            ],
            'legalities': {
              'standard': 'not_legal',
              'future': 'not_legal',
              'historic': 'not_legal',
              'gladiator': 'not_legal',
              'pioneer': 'not_legal',
              'modern': 'legal',
              'legacy': 'legal',
              'pauper': 'not_legal',
              'vintage': 'legal',
              'penny': 'not_legal',
              'commander': 'legal',
              'brawl': 'not_legal',
              'historicbrawl': 'not_legal',
              'alchemy': 'not_legal',
              'paupercommander': 'not_legal',
              'duel': 'restricted',
              'oldschool': 'not_legal',
              'premodern': 'not_legal'
            },
            'games': ['paper', 'mtgo'],
            'reserved': false,
            'foil': true,
            'nonfoil': true,
            'finishes': ['nonfoil', 'foil'],
            'oversized': false,
            'promo': false,
            'reprint': false,
            'variation': false,
            'set_id': 'c1c7eb8c-f205-40ab-a609-767cb296544e',
            'set': 'mh2',
            'set_name': 'Modern Horizons 2',
            'set_type': 'draft_innovation',
            'set_uri':
                'https://api.scryfall.com/sets/c1c7eb8c-f205-40ab-a609-767cb296544e',
            'set_search_uri':
                'https://api.scryfall.com/cards/search?order=set&q=e%3Amh2&unique=prints',
            'scryfall_set_uri': 'https://scryfall.com/sets/mh2?utm_source=api',
            'rulings_uri':
                'https://api.scryfall.com/cards/d99a9a7d-d9ca-4c11-80ab-e39d5943a315/rulings',
            'prints_search_uri':
                'https://api.scryfall.com/cards/search?order=released&q=oracleid%3A1f74e26f-5cf3-4b0e-bcc6-f858599474fc&unique=prints',
            'collector_number': '186',
            'digital': false,
            'rarity': 'rare',
            'card_back_id': '0aeebaf5-8c7d-4636-9e82-8c27447861f7',
            'artist': 'Ryan Pancoast',
            'artist_ids': ['89cc9475-dda2-4d13-bf88-54b92867a25c'],
            'illustration_id': '109aa8fc-4587-4092-9a51-da3a81099ae5',
            'border_color': 'black',
            'frame': '2015',
            'frame_effects': ['legendary'],
            'security_stamp': 'oval',
            'full_art': false,
            'textless': false,
            'booster': true,
            'story_spotlight': false,
            'edhrec_rank': 8208,
            'preview': {
              'source': 'Wizards of the Coast',
              'source_uri':
                  'https://magic.wizards.com/en/articles/archive/card-preview/challenge-accepted-2021-05-26',
              'previewed_at': '2021-05-26'
            },
            'prices': {
              'usd': '0.35',
              'usd_foil': '0.80',
              'usd_etched': null,
              'eur': '0.57',
              'eur_foil': '0.92',
              'tix': '0.59'
            },
            'related_uris': {
              'gatherer':
                  'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=522262',
              'tcgplayer_infinite_articles':
                  'https://infinite.tcgplayer.com/search?contentMode=article&game=magic&partner=scryfall&q=Asmoranomardicadaistinaculdacar&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'tcgplayer_infinite_decks':
                  'https://infinite.tcgplayer.com/search?contentMode=deck&game=magic&partner=scryfall&q=Asmoranomardicadaistinaculdacar&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'edhrec':
                  'https://edhrec.com/route/?cc=Asmoranomardicadaistinaculdacar',
              'mtgtop8':
                  'https://mtgtop8.com/search?MD_check=1&SB_check=1&cards=Asmoranomardicadaistinaculdacar'
            },
            'purchase_uris': {
              'tcgplayer':
                  'https://shop.tcgplayer.com/product/productsearch?id=239722&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'cardmarket':
                  'https://www.cardmarket.com/en/Magic/Products/Search?referrer=scryfall&searchString=Asmoranomardicadaistinaculdacar&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall',
              'cardhoarder':
                  'https://www.cardhoarder.com/cards/90749?affiliate_id=scryfall&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall'
            }
          },
        ];

        final json = jsonEncode({
          'object': 'list',
          'total_cards': totalCards,
          'has_more': hasMore,
          'next_page': nextPageStr,
          'data': data,
        });

        final nextPage = Uri.parse(nextPageStr);

        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await scryfallApiClient.searchCards(
          searchQuery,
          sortingOrder: sortingOrder,
        );
        expect(
          actual,
          isA<PaginableList>()
              .having((l) => l.hasMore, 'hasMore', hasMore)
              .having((l) => l.nextPage, 'nextPage', nextPage)
              .having((l) => l.length, 'length', data.length)
              .having(
                (l) => l.data,
                'data',
                isA<List<MtgCard>>().having(
                  (l) => l.first,
                  'first',
                  isA<MtgCard>(),
                ),
              ),
        );
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
  });
}
