import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Migration', () {
    final id = '3f5b89fc-1b33-40a0-87d4-ea6f2e9515bb';
    final uri =
        'https://api.scryfall.com/migrations/3f5b89fc-1b33-40a0-87d4-ea6f2e9515bb';
    final performedAtStr = '2022-11-10T00:00:00.000';
    final migrationStrategyStr = 'merge';
    final String oldScryfallId = '585fa2cc-4f77-47ab-8d2c-c68258ced283';
    final String newScryfallId = '9052f5c7-ee3b-457d-97ca-ac6b4518997c';
    final String note = 'Actually a reversible card';

    final json = <String, dynamic>{
      'id': id,
      'uri': uri,
      'performed_at': performedAtStr,
      'migration_strategy': migrationStrategyStr,
      'old_scryfall_id': oldScryfallId,
      'new_scryfall_id': newScryfallId,
      'note': note,
    };

    group('fromJson', () {
      test('returns correct Migration', () {
        final performedAt = DateTime.parse(performedAtStr);
        final migrationStrategy = MigrationStrategy.merge;

        expect(
          Migration.fromJson(json),
          isA<Migration>()
              .having((p) => p.id, 'id', id)
              .having((p) => p.uri, 'uri', uri)
              .having((p) => p.performedAt, 'performedAt', performedAt)
              .having((p) => p.migrationStrategy, 'migrationStrategy',
                  migrationStrategy)
              .having((p) => p.oldScryfallId, 'oldScryfallId', oldScryfallId)
              .having((p) => p.newScryfallId, 'newScryfallId', newScryfallId)
              .having((p) => p.note, 'note', note),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          Migration.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
