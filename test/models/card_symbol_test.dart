import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('CardSymbol', () {
    final symbol = '{W}';
    final svgUriStr =
        'https://c2.scryfall.com/file/scryfall-symbols/card-symbols/W.svg';
    final looseVariant = 'W';
    final english = 'one white mana';
    final transposable = false;
    final representsMana = true;
    final appearsInManaCosts = true;
    final cmc = 1;
    final funny = false;
    final colorsStr = ['W'];
    final gathererAlternates = ['oW', 'ooW'];

    final json = <String, dynamic>{
      'symbol': symbol,
      'svg_uri': svgUriStr,
      'loose_variant': looseVariant,
      'english': english,
      'transposable': transposable,
      'represents_mana': representsMana,
      'appears_in_mana_costs': appearsInManaCosts,
      'cmc': cmc,
      'funny': funny,
      'colors': colorsStr,
      'gatherer_alternates': gathererAlternates,
    };
    group('fromJson', () {
      test('returns correct CardSymbol', () {
        final svgUri = Uri.parse(svgUriStr);
        final colors = [Color.white];

        expect(
          CardSymbol.fromJson(json),
          isA<CardSymbol>()
              .having((s) => s.symbol, 'symbol', symbol)
              .having((s) => s.svgUri, 'svgUri', svgUri)
              .having((s) => s.looseVariant, 'looseVariant', looseVariant)
              .having((s) => s.english, 'english', english)
              .having((s) => s.transposable, 'transposable', transposable)
              .having((s) => s.representsMana, 'representsMana', representsMana)
              .having(
                (s) => s.appearsInManaCosts,
                'appearsInManaCosts',
                appearsInManaCosts,
              )
              .having((s) => s.cmc, 'cmc', cmc)
              .having((s) => s.funny, 'funny', funny)
              .having((s) => s.colors, 'colors', colors)
              .having(
                (s) => s.gathererAlternates,
                'gathererAlternates',
                gathererAlternates,
              ),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          CardSymbol.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
