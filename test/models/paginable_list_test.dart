import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('PaginableList', () {
    group('fromJson', () {
      test('returns correct PaginableList<int>', () {
        final hasMore = false;
        final data = [1, 2, 3];

        final json = <String, dynamic>{
          'object': 'list',
          'has_more': hasMore,
          'data': data,
        };

        expect(
          PaginableList<int>.fromJson(json, (o) => o as int),
          isA<PaginableList<int>>()
              .having((l) => l.hasMore, 'hasMore', hasMore)
              .having((l) => l.data, 'data', data),
        );
      });
      test('returns correct PaginableList<String>', () {
        final hasMore = false;
        final data = ['A String', 'Another string'];

        final json = <String, dynamic>{
          'object': 'list',
          'has_more': hasMore,
          'data': data,
        };

        expect(
          PaginableList<String>.fromJson(json, (o) => o as String),
          isA<PaginableList<String>>()
              .having((l) => l.hasMore, 'hasMore', hasMore)
              .having((l) => l.data, 'data', data),
        );
      });
      test('returns correct PaginableList<Map<string, dynamic>>', () {
        final totalCards = 497;
        final hasMore = true;
        final nextPage =
            'https://api.scryfall.com/cards/search?format=json&include_extras=false&include_multilingual=false&order=name&page=2&q=c%3Awhite+cmc%3D1&unique=cards';
        final data = <Map<String, dynamic>>[
          {
            'object': 'card',
            'id': '023b5e6f-10de-422d-8431-11f1fdeca246',
            'oracle_id': 'a2404d88-0621-49ae-9908-052c23a96ac6',
            'multiverse_ids': [2838],
            'tcgplayer_id': 3352,
            'cardmarket_id': 7644,
            'name': 'Abu Ja\'far',
            'lang': 'en',
            'released_at': '1995-07-01',
            'uri':
                'https://api.scryfall.com/cards/023b5e6f-10de-422d-8431-11f1fdeca246',
            'scryfall_uri':
                'https://scryfall.com/card/chr/1/abu-jafar?utm_source=api',
            'layout': 'normal',
            'highres_image': true,
            'image_status': 'highres_scan',
            'image_uris': {
              'small':
                  'https://c1.scryfall.com/file/scryfall-cards/small/front/0/2/023b5e6f-10de-422d-8431-11f1fdeca246.jpg?1562895407',
              'normal':
                  'https://c1.scryfall.com/file/scryfall-cards/normal/front/0/2/023b5e6f-10de-422d-8431-11f1fdeca246.jpg?1562895407',
              'large':
                  'https://c1.scryfall.com/file/scryfall-cards/large/front/0/2/023b5e6f-10de-422d-8431-11f1fdeca246.jpg?1562895407',
              'png':
                  'https://c1.scryfall.com/file/scryfall-cards/png/front/0/2/023b5e6f-10de-422d-8431-11f1fdeca246.png?1562895407',
              'art_crop':
                  'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/0/2/023b5e6f-10de-422d-8431-11f1fdeca246.jpg?1562895407',
              'border_crop':
                  'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/0/2/023b5e6f-10de-422d-8431-11f1fdeca246.jpg?1562895407'
            },
            'mana_cost': '{W}',
            'cmc': 1,
            'type_line': 'Creature — Human',
            'oracle_text':
                'When Abu Ja\'far dies, destroy all creatures blocking or blocked by it. They can\'t be regenerated.',
            'power': '0',
            'toughness': '1',
            'colors': ['W'],
            'color_identity': ['W'],
            'keywords': [],
            'legalities': {
              'standard': 'not_legal',
              'future': 'not_legal',
              'historic': 'not_legal',
              'gladiator': 'not_legal',
              'pioneer': 'not_legal',
              'modern': 'not_legal',
              'legacy': 'legal',
              'pauper': 'not_legal',
              'vintage': 'legal',
              'penny': 'not_legal',
              'commander': 'legal',
              'brawl': 'not_legal',
              'historicbrawl': 'not_legal',
              'alchemy': 'not_legal',
              'paupercommander': 'restricted',
              'duel': 'legal',
              'oldschool': 'legal',
              'premodern': 'legal'
            },
            'games': ['paper'],
            'reserved': false,
            'foil': false,
            'nonfoil': true,
            'finishes': ['nonfoil'],
            'oversized': false,
            'promo': false,
            'reprint': true,
            'variation': false,
            'set_id': '985eab7d-655a-4cb0-ba74-d48c8dcfb3d4',
            'set': 'chr',
            'set_name': 'Chronicles',
            'set_type': 'masters',
            'set_uri':
                'https://api.scryfall.com/sets/985eab7d-655a-4cb0-ba74-d48c8dcfb3d4',
            'set_search_uri':
                'https://api.scryfall.com/cards/search?order=set&q=e%3Achr&unique=prints',
            'scryfall_set_uri': 'https://scryfall.com/sets/chr?utm_source=api',
            'rulings_uri':
                'https://api.scryfall.com/cards/023b5e6f-10de-422d-8431-11f1fdeca246/rulings',
            'prints_search_uri':
                'https://api.scryfall.com/cards/search?order=released&q=oracleid%3Aa2404d88-0621-49ae-9908-052c23a96ac6&unique=prints',
            'collector_number': '1',
            'digital': false,
            'rarity': 'uncommon',
            'card_back_id': '0aeebaf5-8c7d-4636-9e82-8c27447861f7',
            'artist': 'Ken Meyer, Jr.',
            'artist_ids': ['466f5d1e-384e-47d9-8d2c-c6ae33ffa687'],
            'illustration_id': '949634bd-2f5a-4be7-ad24-d7039a57b6d6',
            'border_color': 'white',
            'frame': '1993',
            'full_art': false,
            'textless': false,
            'booster': true,
            'story_spotlight': false,
            'edhrec_rank': 14745,
            'prices': {
              'usd': '0.24',
              'usd_foil': null,
              'usd_etched': null,
              'eur': '0.14',
              'eur_foil': null,
              'tix': null
            },
            'related_uris': {
              'gatherer':
                  'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=2838',
              'tcgplayer_infinite_articles':
                  'https://infinite.tcgplayer.com/search?contentMode=article&game=magic&partner=scryfall&q=Abu+Ja%27far&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'tcgplayer_infinite_decks':
                  'https://infinite.tcgplayer.com/search?contentMode=deck&game=magic&partner=scryfall&q=Abu+Ja%27far&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'edhrec': 'https://edhrec.com/route/?cc=Abu+Ja%27far',
              'mtgtop8':
                  'https://mtgtop8.com/search?MD_check=1&SB_check=1&cards=Abu+Ja%27far'
            },
            'purchase_uris': {
              'tcgplayer':
                  'https://shop.tcgplayer.com/product/productsearch?id=3352&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'cardmarket':
                  'https://www.cardmarket.com/en/Magic/Products/Search?referrer=scryfall&searchString=Abu+Ja%27far&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall',
              'cardhoarder':
                  'https://www.cardhoarder.com/cards?affiliate_id=scryfall&data%5Bsearch%5D=Abu+Ja%27far&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall'
            }
          },
          {
            'object': 'card',
            'id': 'd25ff6aa-a01d-49f2-926f-8f5457143b5c',
            'oracle_id': '748d5353-b66c-4d7a-8c55-0d28fefb1e2a',
            'multiverse_ids': [479485],
            'tcgplayer_id': 208588,
            'cardmarket_id': 438159,
            'name': 'Adorable Kitten',
            'lang': 'en',
            'released_at': '2020-02-29',
            'uri':
                'https://api.scryfall.com/cards/d25ff6aa-a01d-49f2-926f-8f5457143b5c',
            'scryfall_uri':
                'https://scryfall.com/card/und/1/adorable-kitten?utm_source=api',
            'layout': 'host',
            'highres_image': true,
            'image_status': 'highres_scan',
            'image_uris': {
              'small':
                  'https://c1.scryfall.com/file/scryfall-cards/small/front/d/2/d25ff6aa-a01d-49f2-926f-8f5457143b5c.jpg?1583542840',
              'normal':
                  'https://c1.scryfall.com/file/scryfall-cards/normal/front/d/2/d25ff6aa-a01d-49f2-926f-8f5457143b5c.jpg?1583542840',
              'large':
                  'https://c1.scryfall.com/file/scryfall-cards/large/front/d/2/d25ff6aa-a01d-49f2-926f-8f5457143b5c.jpg?1583542840',
              'png':
                  'https://c1.scryfall.com/file/scryfall-cards/png/front/d/2/d25ff6aa-a01d-49f2-926f-8f5457143b5c.png?1583542840',
              'art_crop':
                  'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/d/2/d25ff6aa-a01d-49f2-926f-8f5457143b5c.jpg?1583542840',
              'border_crop':
                  'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/d/2/d25ff6aa-a01d-49f2-926f-8f5457143b5c.jpg?1583542840'
            },
            'mana_cost': '{W}',
            'cmc': 1,
            'type_line': 'Host Creature — Cat',
            'oracle_text':
                'When this creature enters the battlefield, roll a six-sided die. You gain life equal to the result.',
            'power': '1',
            'toughness': '1',
            'colors': ['W'],
            'color_identity': ['W'],
            'keywords': [],
            'legalities': {
              'standard': 'not_legal',
              'future': 'not_legal',
              'historic': 'not_legal',
              'gladiator': 'not_legal',
              'pioneer': 'not_legal',
              'modern': 'not_legal',
              'legacy': 'not_legal',
              'pauper': 'not_legal',
              'vintage': 'not_legal',
              'penny': 'not_legal',
              'commander': 'not_legal',
              'brawl': 'not_legal',
              'historicbrawl': 'not_legal',
              'alchemy': 'not_legal',
              'paupercommander': 'not_legal',
              'duel': 'not_legal',
              'oldschool': 'not_legal',
              'premodern': 'not_legal'
            },
            'games': ['paper'],
            'reserved': false,
            'foil': false,
            'nonfoil': true,
            'finishes': ['nonfoil'],
            'oversized': false,
            'promo': false,
            'reprint': true,
            'variation': false,
            'set_id': 'fccfdf97-f5f2-43b4-9be9-9255414e6633',
            'set': 'und',
            'set_name': 'Unsanctioned',
            'set_type': 'funny',
            'set_uri':
                'https://api.scryfall.com/sets/fccfdf97-f5f2-43b4-9be9-9255414e6633',
            'set_search_uri':
                'https://api.scryfall.com/cards/search?order=set&q=e%3Aund&unique=prints',
            'scryfall_set_uri': 'https://scryfall.com/sets/und?utm_source=api',
            'rulings_uri':
                'https://api.scryfall.com/cards/d25ff6aa-a01d-49f2-926f-8f5457143b5c/rulings',
            'prints_search_uri':
                'https://api.scryfall.com/cards/search?order=released&q=oracleid%3A748d5353-b66c-4d7a-8c55-0d28fefb1e2a&unique=prints',
            'collector_number': '1',
            'digital': false,
            'rarity': 'common',
            'card_back_id': '0aeebaf5-8c7d-4636-9e82-8c27447861f7',
            'artist': 'Andrea Radeck',
            'artist_ids': ['2560b932-96b5-4308-9d32-298641ef326e'],
            'illustration_id': '1f485137-7768-4832-b917-d0cbec57639e',
            'border_color': 'silver',
            'frame': '2015',
            'full_art': false,
            'textless': false,
            'booster': false,
            'story_spotlight': false,
            'prices': {
              'usd': '0.12',
              'usd_foil': null,
              'usd_etched': null,
              'eur': '0.05',
              'eur_foil': null,
              'tix': null
            },
            'related_uris': {
              'gatherer':
                  'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=479485',
              'tcgplayer_infinite_articles':
                  'https://infinite.tcgplayer.com/search?contentMode=article&game=magic&partner=scryfall&q=Adorable+Kitten&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'tcgplayer_infinite_decks':
                  'https://infinite.tcgplayer.com/search?contentMode=deck&game=magic&partner=scryfall&q=Adorable+Kitten&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'edhrec': 'https://edhrec.com/route/?cc=Adorable+Kitten',
              'mtgtop8':
                  'https://mtgtop8.com/search?MD_check=1&SB_check=1&cards=Adorable+Kitten'
            },
            'purchase_uris': {
              'tcgplayer':
                  'https://shop.tcgplayer.com/product/productsearch?id=208588&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
              'cardmarket':
                  'https://www.cardmarket.com/en/Magic/Products/Search?referrer=scryfall&searchString=Adorable+Kitten&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall',
              'cardhoarder':
                  'https://www.cardhoarder.com/cards?affiliate_id=scryfall&data%5Bsearch%5D=Adorable+Kitten&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall'
            }
          },
        ];

        final json = <String, dynamic>{
          'object': 'list',
          'total_cards': totalCards,
          'has_more': hasMore,
          'next_page': nextPage,
          'data': data,
        };

        expect(
          PaginableList<Map<String, dynamic>>.fromJson(
            json,
            (o) => o as Map<String, dynamic>,
          ),
          isA<PaginableList<Map<String, dynamic>>>()
              .having((l) => l.totalCards, 'totalCards', totalCards)
              .having((l) => l.nextPage, 'nextPage', Uri.parse(nextPage))
              .having((l) => l.data, 'data', data),
        );
      });
      test('returns correct PaginableList<MtgSet>', () {
        final hasMore = false;
        final data = <Map<String, dynamic>>[
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
                'https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1640581200'
          },
          {
            'object': 'set',
            'id': 'a60124f9-8002-4769-ac16-387b61fa2bc6',
            'code': 'tunf',
            'name': 'Unfinity Tokens',
            'uri':
                'https://api.scryfall.com/sets/a60124f9-8002-4769-ac16-387b61fa2bc6',
            'scryfall_uri': 'https://scryfall.com/sets/tunf',
            'search_uri':
                'https://api.scryfall.com/cards/search?order=set&q=e%3Atunf&unique=prints',
            'released_at': '2022-04-01',
            'set_type': 'token',
            'card_count': 0,
            'parent_set_code': 'unf',
            'digital': false,
            'nonfoil_only': true,
            'foil_only': true,
            'icon_svg_uri':
                'https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1640581200'
          },
          {
            'object': 'set',
            'id': 'b11b2817-d7b5-4207-9271-e109936561ed',
            'code': 'pw22',
            'name': 'Wizards Play Network 2022',
            'uri':
                'https://api.scryfall.com/sets/b11b2817-d7b5-4207-9271-e109936561ed',
            'scryfall_uri': 'https://scryfall.com/sets/pw22',
            'search_uri':
                'https://api.scryfall.com/cards/search?order=set&q=e%3Apw22&unique=prints',
            'released_at': '2022-03-05',
            'set_type': 'promo',
            'card_count': 3,
            'digital': false,
            'nonfoil_only': false,
            'foil_only': true,
            'icon_svg_uri':
                'https://c2.scryfall.com/file/scryfall-symbols/sets/star.svg?1640581200'
          },
        ];

        final json = <String, dynamic>{
          'object': 'list',
          'has_more': hasMore,
          'data': data,
        };

        expect(
          PaginableList<MtgSet>.fromJson(
            json,
            (o) => MtgSet.fromJson(o as Map<String, dynamic>),
          ),
          isA<PaginableList<MtgSet>>()
              .having((l) => l.hasMore, 'hasMore', hasMore)
              .having(
                (l) => l.data,
                'data',
                isA<List<MtgSet>>()
                    .having((l) => l.length, 'length', data.length)
                    .having((l) => l[0].name, '[0].name', 'Unfinity')
                    .having((l) => l[1].name, '[1].name', 'Unfinity Tokens')
                    .having(
                      (l) => l[2].name,
                      '[2].name',
                      'Wizards Play Network 2022',
                    ),
              ),
        );
      });
    });

    group('length', () {
      late PaginableList<int> list;

      setUp(() {
        list = PaginableList(
          hasMore: false,
          data: [1, 2, 3],
        );
      });

      test('returns correct length', () {
        expect(list.length, 3);
      });
    });

    group('operator []', () {
      late PaginableList<int> list;

      setUp(() {
        list = PaginableList(
          hasMore: false,
          data: [1, 2, 3, 4, 5],
        );
      });
      test('returns correct entries', () {
        expect(list[0], 1);
        expect(list[1], 2);
        expect(list[2], 3);
        expect(list[3], 4);
        expect(list[4], 5);
      });

      test('throws RangeError for invalid index', () {
        expect(() => list[-1], throwsA(isA<RangeError>()));
        expect(() => list[5], throwsA(isA<RangeError>()));
      });
    });
  });
}
