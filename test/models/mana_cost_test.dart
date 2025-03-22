import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('ManaCost', () {
    final cost = '{X}{U}{R}';
    final colorsStr = ['U', 'R'];
    final cmc = 2;
    final colorless = false;
    final monocolored = false;
    final multicolored = true;

    final json = <String, dynamic>{
      'object': 'mana_cost',
      'cost': cost,
      'colors': colorsStr,
      'cmc': cmc,
      'colorless': colorless,
      'monocolored': monocolored,
      'multicolored': multicolored,
    };

    group('fromJson', () {
      test('returns correct ManaCost', () {
        final colors = [Color.blue, Color.red];

        expect(
          ManaCost.fromJson(json),
          isA<ManaCost>()
              .having((c) => c.cost, 'cost', cost)
              .having((c) => c.colors, 'colors', colors)
              .having((c) => c.cmc, 'cmc', cmc)
              .having((c) => c.colorless, 'colorless', colorless)
              .having((c) => c.monocolored, 'monocolored', monocolored)
              .having((c) => c.multicolored, 'multicolored', multicolored),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          ManaCost.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
