import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Catalog', () {
    final uriStr = 'https://api.scryfall.com/catalog/land-types';
    final data = [
      'Desert',
      'Forest',
      'Gate',
      'Island',
      'Lair',
      'Locus',
      'Mine',
      'Mountain',
      'Plains',
      'Power-Plant',
      'Swamp',
      'Tower',
      'Urza’s'
    ];

    final json = <String, dynamic>{
      'object': 'catalog',
      'uri': uriStr,
      'data': data,
    };
    group('fromJson', () {
      test('returns correct Catalog', () {
        final uri = Uri.parse(uriStr);

        expect(
          Catalog.fromJson(json),
          isA<Catalog>()
              .having((c) => c.uri, 'uri', uri)
              .having((c) => c.length, 'length', data.length)
              .having((c) => c.data, 'data', data)
              .having((c) => c[4], 'element with index 4', data[4]),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          Catalog.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
