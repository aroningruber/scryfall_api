import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Legalities', () {
    group('fromJson', () {
      test('returns correct Legalities', () {
        final standard_str = 'legal';
        final future_str = 'legal';
        final historic_str = 'legal';
        final gladiator_str = 'legal';
        final pioneer_str = 'legal';
        final modern_str = 'legal';
        final legacy_str = 'legal';
        final pauper_str = 'not_legal';
        final vintage_str = 'legal';
        final penny_str = 'not_legal';
        final commander_str = 'legal';
        final brawl_str = 'legal';
        final historicbrawl_str = 'legal';
        final alchemy_str = 'legal';
        final paupercommander_str = 'not_legal';
        final duel_str = 'legal';
        final oldschool_str = 'not_legal';
        final premodern_str = 'not_legal';

        final json = <String, dynamic>{
          'standard': standard_str,
          'future': future_str,
          'historic': historic_str,
          'gladiator': gladiator_str,
          'pioneer': pioneer_str,
          'modern': modern_str,
          'legacy': legacy_str,
          'pauper': pauper_str,
          'vintage': vintage_str,
          'penny': penny_str,
          'commander': commander_str,
          'brawl': brawl_str,
          'historicbrawl': historicbrawl_str,
          'alchemy': alchemy_str,
          'paupercommander': paupercommander_str,
          'duel': duel_str,
          'oldschool': oldschool_str,
          'premodern': premodern_str,
        };

        final standard = Legality.legal;
        final future = Legality.legal;
        final historic = Legality.legal;
        final gladiator = Legality.legal;
        final pioneer = Legality.legal;
        final modern = Legality.legal;
        final legacy = Legality.legal;
        final pauper = Legality.notLegal;
        final vintage = Legality.legal;
        final penny = Legality.notLegal;
        final commander = Legality.legal;
        final brawl = Legality.legal;
        final historicbrawl = Legality.legal;
        final alchemy = Legality.legal;
        final paupercommander = Legality.notLegal;
        final duel = Legality.legal;
        final oldschool = Legality.notLegal;
        final premodern = Legality.notLegal;

        expect(
          Legalities.fromJson(json),
          isA<Legalities>()
              .having((l) => l.standard, 'standard', standard)
              .having((l) => l.future, 'future', future)
              .having((l) => l.historic, 'historic', historic)
              .having((l) => l.gladiator, 'gladiator', gladiator)
              .having((l) => l.pioneer, 'pioneer', pioneer)
              .having((l) => l.modern, 'modern', modern)
              .having((l) => l.legacy, 'legacy', legacy)
              .having((l) => l.pauper, 'pauper', pauper)
              .having((l) => l.vintage, 'vintage', vintage)
              .having((l) => l.penny, 'penny', penny)
              .having((l) => l.commander, 'commander', commander)
              .having((l) => l.brawl, 'brawl', brawl)
              .having((l) => l.historicbrawl, 'historicbrawl', historicbrawl)
              .having((l) => l.alchemy, 'alchemy', alchemy)
              .having(
                (l) => l.paupercommander,
                'paupercommander',
                paupercommander,
              )
              .having((l) => l.duel, 'duel', duel)
              .having((l) => l.oldschool, 'oldschool', oldschool)
              .having((l) => l.premodern, 'premodern', premodern),
        );
      });
    });
  });
}
