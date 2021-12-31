import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Prices', () {
    group('fromJson', () {
      test('returns correct Prices', () {
        final usd = '1.09';
        final usdFoil = '1.62';
        final usdEtched = null;
        final eur = '1.88';
        final eurFoil = '2.25';
        final tix = '2.04';

        final json = <String, dynamic>{
          'usd': usd,
          'usd_foil': usdFoil,
          'usd_etched': usdEtched,
          'eur': eur,
          'eur_foil': eurFoil,
          'tix': tix,
        };

        expect(
          Prices.fromJson(json),
          isA<Prices>()
              .having((p) => p.usd, 'usd', usd)
              .having((p) => p.usdFoil, 'usdFoil', usdFoil)
              .having((p) => p.usdEtched, 'usdEtched', usdEtched)
              .having((p) => p.eur, 'eur', eur)
              .having((p) => p.eurFoil, 'eurFoil', eurFoil)
              .having((p) => p.tix, 'tix', tix),
        );
      });
    });
  });
}
