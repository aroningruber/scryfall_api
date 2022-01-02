import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Language', () {
    group('name', () {
      test('returns correct language code', () {
        expect(Language.english.json, 'en');
        expect(Language.spanish.json, 'es');
        expect(Language.french.json, 'fr');
        expect(Language.italian.json, 'it');
        expect(Language.portuguese.json, 'pt');
        expect(Language.japanese.json, 'ja');
        expect(Language.korean.json, 'ko');
        expect(Language.russian.json, 'ru');
        expect(Language.chineseSimplified.json, 'zhs');
        expect(Language.chineseTraditional.json, 'zht');
        expect(Language.hebrew.json, 'he');
        expect(Language.latin.json, 'la');
        expect(Language.ancientGreek.json, 'grc');
        expect(Language.arabic.json, 'ar');
        expect(Language.sanskrit.json, 'sa');
        expect(Language.phyrexian.json, 'ph');
      });
    });
  });
}
