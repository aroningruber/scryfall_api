import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Language', () {
    group('name', () {
      test('returns correct language code', () {
        expect(Language.english.name, 'en');
        expect(Language.spanish.name, 'es');
        expect(Language.french.name, 'fr');
        expect(Language.italian.name, 'it');
        expect(Language.portuguese.name, 'pt');
        expect(Language.japanese.name, 'ja');
        expect(Language.korean.name, 'ko');
        expect(Language.russian.name, 'ru');
        expect(Language.chineseSimplified.name, 'zhs');
        expect(Language.chineseTraditional.name, 'zht');
        expect(Language.hebrew.name, 'he');
        expect(Language.latin.name, 'la');
        expect(Language.ancientGreek.name, 'grc');
        expect(Language.arabic.name, 'ar');
        expect(Language.sanskrit.name, 'sa');
        expect(Language.phyrexian.name, 'ph');
      });
    });
  });
}
