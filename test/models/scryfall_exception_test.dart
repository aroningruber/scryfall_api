import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('ScryfallException', () {
    final code = 'bad_request';
    final status = 400;
    final warnings = [
      'Invalid expression “is:slick” was ignored. Checking if cards are “slick” is not supported',
      'Invalid expression “cmc>cmc” was ignored. The sides of your comparison must be different.'
    ];
    final details = 'All of your terms were ignored.';

    final json = <String, dynamic>{
      'object': 'error',
      'code': code,
      'status': status,
      'warnings': warnings,
      'details': details,
      'type': null,
    };
    group('fromJson', () {
      test('returns correct ScryfallException', () {
        expect(
          ScryfallException.fromJson(json),
          isA<ScryfallException>()
              .having((e) => e.code, 'code', code)
              .having((e) => e.status, 'status', status)
              .having((e) => e.warnings, 'warnings', warnings)
              .having((e) => e.details, 'details', details),
        );
      });
    });

    group('toJson', () {
      test('returns correct JSON', () {
        expect(
          ScryfallException.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
