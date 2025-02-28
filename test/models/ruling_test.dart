import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Ruling', () {
    final oracleId = 'afa49a09-146f-4439-850e-dd1938c93cef';
    final sourceStr = 'wotc';
    final publishedAtStr = '2020-11-10T00:00:00.000';
    final comment =
        'You can activate Derevi’s last ability only when it is in the command zone.';

    final json = <String, dynamic>{
      'oracle_id': oracleId,
      'source': sourceStr,
      'published_at': publishedAtStr,
      'comment': comment,
    };

    group('fromJson', () {
      test('returns correct Ruling', () {
        final source = RulingSource.wizardsOfTheCoast;
        final publishedAt = DateTime.parse(publishedAtStr);

        expect(
          Ruling.fromJson(json),
          isA<Ruling>()
              .having((r) => r.oracleId, 'oracleId', oracleId)
              .having((r) => r.source, 'source', source)
              .having((r) => r.publishedAt, 'publishedAt', publishedAt)
              .having((r) => r.comment, 'comment', comment),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          Ruling.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
