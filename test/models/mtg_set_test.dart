import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('MtgSet', () {
    final id = 'b314f553-8f07-4ba9-96c8-16be7784eff3';
    final code = 'unf';
    final tcgplayerId = 2958;
    final name = 'Unfinity';
    final uri =
        'https://api.scryfall.com/sets/b314f553-8f07-4ba9-96c8-16be7784eff3';
    final scryfallUri = 'https://scryfall.com/sets/unf';
    final searchUri =
        'https://api.scryfall.com/cards/search?order=set&q=e%3Aunf&unique=prints';
    final releasedAt = '2022-04-01T00:00:00.000';
    final setType = 'funny';
    final cardCount = 26;
    final digital = false;
    final nonfoilOnly = false;
    final foilOnly = false;
    final iconSvgUri =
        'https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1640581200';

    late Map<String, dynamic> json;

    setUp(
      () => {
        json = <String, dynamic>{
          'object': 'set',
          'id': id,
          'code': code,
          'tcgplayer_id': tcgplayerId,
          'name': name,
          'uri': uri,
          'scryfall_uri': scryfallUri,
          'search_uri': searchUri,
          'released_at': releasedAt,
          'set_type': setType,
          'card_count': cardCount,
          'digital': digital,
          'nonfoil_only': nonfoilOnly,
          'foil_only': foilOnly,
          'icon_svg_uri': iconSvgUri,
        }
      },
    );

    group('fromJson', () {
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
              .having((s) => s.tcgplayerId, 'tcgplayerId', tcgplayerId)
              .having((s) => s.name, 'name', name)
              .having((s) => s.uri, 'uri', Uri.parse(uri))
              .having(
                (s) => s.scryfallUri,
                'scryfallUri',
                Uri.parse(scryfallUri),
              )
              .having(
                (s) => s.searchUri,
                'searchUri',
                Uri.parse(searchUri),
              )
              .having(
                (s) => s.releasedAt,
                'releasedAt',
                DateTime.parse(releasedAt),
              )
              .having((s) => s.setType, 'setType', SetType.funny)
              .having((s) => s.cardCount, 'cardCount', cardCount)
              .having((s) => s.digital, 'digital', digital)
              .having((s) => s.nonfoilOnly, 'nonFoilOnly', nonfoilOnly)
              .having((s) => s.foilOnly, 'foilOnly', foilOnly)
              .having(
                (s) => s.iconSvgUri,
                'iconSvgUri',
                Uri.parse(iconSvgUri),
              ),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          MtgSet.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
