import 'package:scryfall_api/src/models/migration.dart';
import 'package:test/test.dart';

void main() {
  group('Migration', () {
    group('fromJson', () {
      test('returns correct Migration', () {
        final id = '3f5b89fc-1b33-40a0-87d4-ea6f2e9515bb';
        final uri =
            'https://api.scryfall.com/migrations/3f5b89fc-1b33-40a0-87d4-ea6f2e9515bb';
        final performedAt = DateTime(2022, 12, 3).toString();
        final migrationStrategy = 'merge';
        final String oldScryfallId = '585fa2cc-4f77-47ab-8d2c-c68258ced283';
        final String newScryfallId = '9052f5c7-ee3b-457d-97ca-ac6b4518997c';
        final String note = 'Actually a reversible card';

        final json = <String, dynamic>{
          'object': 'migration',
          'id': id,
          'uri': uri,
          'performed_at': performedAt,
          'migration_strategy': migrationStrategy,
          'old_scryfall_id': oldScryfallId,
          'new_scryfall_id': newScryfallId,
          'note': note,
        };

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
  });
}
