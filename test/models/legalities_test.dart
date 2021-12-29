import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Legalities', () {
    group('fromJson', () {
      test('returns correct Legalities', () {
        final standardStr = 'legal';
        final futureStr = 'legal';
        final historicStr = 'legal';
        final gladiatorStr = 'legal';
        final pioneerStr = 'legal';
        final modernStr = 'legal';
        final legacyStr = 'legal';
        final pauperStr = 'not_legal';
        final vintageStr = 'legal';
        final pennyStr = 'not_legal';
        final commanderStr = 'legal';
        final brawlStr = 'legal';
        final historicbrawlStr = 'legal';
        final alchemyStr = 'legal';
        final paupercommanderStr = 'not_legal';
        final duelStr = 'legal';
        final oldschoolStr = 'not_legal';
        final premodernStr = 'not_legal';

        final json = <String, dynamic>{
          'standard': standardStr,
          'future': futureStr,
          'historic': historicStr,
          'gladiator': gladiatorStr,
          'pioneer': pioneerStr,
          'modern': modernStr,
          'legacy': legacyStr,
          'pauper': pauperStr,
          'vintage': vintageStr,
          'penny': pennyStr,
          'commander': commanderStr,
          'brawl': brawlStr,
          'historicbrawl': historicbrawlStr,
          'alchemy': alchemyStr,
          'paupercommander': paupercommanderStr,
          'duel': duelStr,
          'oldschool': oldschoolStr,
          'premodern': premodernStr,
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
