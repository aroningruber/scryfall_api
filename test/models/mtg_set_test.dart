import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('MtgSet', () {
    group('fromJson', () {
      final id = 'b314f553-8f07-4ba9-96c8-16be7784eff3';
      final code = 'unf';
      final tcgplayer_id = 2958;
      final name = 'Unfinity';
      final uri =
          'https://api.scryfall.com/sets/b314f553-8f07-4ba9-96c8-16be7784eff3';
      final scryfall_uri = 'https://scryfall.com/sets/unf';
      final search_uri =
          'https://api.scryfall.com/cards/search?order=set&q=e%3Aunf&unique=prints';
      final released_at = '2022-04-01';
      final set_type = 'funny';
      final card_count = 26;
      final digital = false;
      final nonfoil_only = false;
      final foil_only = false;
      final icon_svg_uri =
          'https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1640581200';

      late Map<String, dynamic> json;

      setUp(
        () => {
          json = <String, dynamic>{
            'object': 'set',
            'id': id,
            'code': code,
            'tcgplayer_id': tcgplayer_id,
            'name': name,
            'uri': uri,
            'scryfall_uri': scryfall_uri,
            'search_uri': search_uri,
            'released_at': released_at,
            'set_type': set_type,
            'card_count': card_count,
            'digital': digital,
            'nonfoil_only': nonfoil_only,
            'foil_only': foil_only,
            'icon_svg_uri': icon_svg_uri,
          }
        },
      );

      test('returns SetType.unknown for unsupported set_type', () {
        json.update('set_type', (_) => 'UNKNOWN');

        expect(
          MtgSet.fromJson(json),
          isA<MtgSet>().having(
            (s) => s.setType,
            'setType',
            SetType.unknown,
          ),
        );
      });

      test('returns correct MtgSet', () {
        expect(
          MtgSet.fromJson(json),
          isA<MtgSet>()
              .having((s) => s.id, 'id', id)
              .having((s) => s.code, 'code', code)
              .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayer_id)
              .having((s) => s.name, 'name', name)
              .having((s) => s.uri, 'uri', Uri.parse(uri))
              .having(
                (s) => s.scryfallUri,
                'scryfallUri',
                Uri.parse(scryfall_uri),
              )
              .having(
                (s) => s.searchUri,
                'searchUri',
                Uri.parse(search_uri),
              )
              .having(
                (s) => s.releasedAt,
                'releasedAt',
                DateTime.parse(released_at),
              )
              .having((s) => s.setType, 'setType', SetType.funny)
              .having((s) => s.cardCount, 'cardCount', card_count)
              .having((s) => s.digital, 'digital', digital)
              .having((s) => s.nonfoilOnly, 'nonFoilOnly', nonfoil_only)
              .having((s) => s.foilOnly, 'foilOnly', foil_only)
              .having(
                (s) => s.iconSvgUri,
                'iconSvgUri',
                Uri.parse(icon_svg_uri),
              ),
        );
      });
    });
  });
}
