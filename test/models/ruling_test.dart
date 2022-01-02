import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Ruling', () {
    group('fromJson', () {
      test('returns correct Ruling', () {
        final oracleId = 'afa49a09-146f-4439-850e-dd1938c93cef';
        final sourceStr = 'wotc';
        final publishedAtStr = '2020-11-10';
        final comment =
            'You can activate Derevi’s last ability only when it is in the command zone.';

        final json = <String, dynamic>{
          'object': 'ruling',
          'oracle_id': oracleId,
          'source': sourceStr,
          'published_at': publishedAtStr,
          'comment': comment,
        };

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
  });
}
