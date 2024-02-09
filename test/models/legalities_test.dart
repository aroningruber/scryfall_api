import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Legalities', () {
    group('fromJson', () {
      test('returns correct Legalities', () {
        final standardStr = 'legal';
        final futureStr = 'legal';
        final historicStr = 'legal';
        final timelessStr = 'not_legal';
        final gladiatorStr = 'legal';
        final pioneerStr = 'legal';
        final explorerStr = 'legal';
        final modernStr = 'legal';
        final legacyStr = 'legal';
        final pauperStr = 'not_legal';
        final vintageStr = 'legal';
        final pennyStr = 'not_legal';
        final commanderStr = 'legal';
        final oathbreakerStr = 'not_legal';
        final brawlStr = 'legal';
        final standardbrawlStr = 'legal';
        final alchemyStr = 'legal';
        final paupercommanderStr = 'not_legal';
        final duelStr = 'legal';
        final oldschoolStr = 'not_legal';
        final premodernStr = 'not_legal';
        final predhStr = 'legal';

        final json = <String, dynamic>{
          'standard': standardStr,
          'future': futureStr,
          'historic': historicStr,
          'timeless': timelessStr,
          'gladiator': gladiatorStr,
          'pioneer': pioneerStr,
          'explorer': explorerStr,
          'modern': modernStr,
          'legacy': legacyStr,
          'pauper': pauperStr,
          'vintage': vintageStr,
          'penny': pennyStr,
          'commander': commanderStr,
          'oathbreaker': oathbreakerStr,
          'brawl': brawlStr,
          'standardbrawl': standardbrawlStr,
          'alchemy': alchemyStr,
          'paupercommander': paupercommanderStr,
          'duel': duelStr,
          'oldschool': oldschoolStr,
          'premodern': premodernStr,
          'predh': predhStr,
        };

        final standard = Legality.legal;
        final future = Legality.legal;
        final historic = Legality.legal;
        final timeless = Legality.notLegal;
        final gladiator = Legality.legal;
        final pioneer = Legality.legal;
        final explorer = Legality.legal;
        final modern = Legality.legal;
        final legacy = Legality.legal;
        final pauper = Legality.notLegal;
        final vintage = Legality.legal;
        final penny = Legality.notLegal;
        final commander = Legality.legal;
        final oathbreaker = Legality.notLegal;
        final brawl = Legality.legal;
        final standardbrawl = Legality.legal;
        final alchemy = Legality.legal;
        final paupercommander = Legality.notLegal;
        final duel = Legality.legal;
        final oldschool = Legality.notLegal;
        final premodern = Legality.notLegal;
        final predh = Legality.legal;

        expect(
          Legalities.fromJson(json),
          isA<Legalities>()
              .having((l) => l.standard, 'standard', standard)
              .having((l) => l.future, 'future', future)
              .having((l) => l.historic, 'historic', historic)
              .having((l) => l.timeless, 'timeless', timeless)
              .having((l) => l.gladiator, 'gladiator', gladiator)
              .having((l) => l.pioneer, 'pioneer', pioneer)
              .having((l) => l.explorer, 'explorer', explorer)
              .having((l) => l.modern, 'modern', modern)
              .having((l) => l.legacy, 'legacy', legacy)
              .having((l) => l.pauper, 'pauper', pauper)
              .having((l) => l.vintage, 'vintage', vintage)
              .having((l) => l.penny, 'penny', penny)
              .having((l) => l.commander, 'commander', commander)
              .having((l) => l.oathbreaker, 'oathbreaker', oathbreaker)
              .having((l) => l.brawl, 'brawl', brawl)
              .having((l) => l.standardbrawl, 'standardbrawl', standardbrawl)
              .having((l) => l.alchemy, 'alchemy', alchemy)
              .having(
                (l) => l.paupercommander,
                'paupercommander',
                paupercommander,
              )
              .having((l) => l.duel, 'duel', duel)
              .having((l) => l.oldschool, 'oldschool', oldschool)
              .having((l) => l.premodern, 'premodern', premodern)
              .having((l) => l.predh, 'predh', predh),
        );
      });
    });
  });
}
