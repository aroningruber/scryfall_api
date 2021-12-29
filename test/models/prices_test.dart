import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Prices', () {
    group('fromJson', () {
      test('returns correct Prices', () {
        final usd = '1.09';
        final usd_foil = '1.62';
        final usd_etched = null;
        final eur = '1.88';
        final eur_foil = '2.25';
        final tix = '2.04';

        final json = <String, dynamic>{
          'usd': usd,
          'usd_foil': usd_foil,
          'usd_etched': usd_etched,
          'eur': eur,
          'eur_foil': eur_foil,
          'tix': tix,
        };

        expect(
          Prices.fromJson(json),
          isA<Prices>()
              .having((p) => p.usd, 'usd', usd)
              .having((p) => p.usdFoil, 'usdFoil', usd_foil)
              .having((p) => p.usdEtched, 'usdEtched', usd_etched)
              .having((p) => p.eur, 'eur', eur)
              .having((p) => p.eurFoil, 'eurFoil', eur_foil)
              .having((p) => p.tix, 'tix', tix),
        );
      });
    });
  });
}
