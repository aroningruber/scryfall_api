// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Migration _$MigrationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Migration',
      json,
      ($checkedConvert) {
        final val = Migration(
          id: $checkedConvert('id', (v) => v as String),
          uri: $checkedConvert('uri', (v) => v as String),
          performedAt: $checkedConvert('performed_at', (v) => v as String),
          migrationStrategy:
              $checkedConvert('migration_strategy', (v) => v as String),
          oldScryfallId: $checkedConvert('old_scryfall_id', (v) => v as String),
          newScryfallId:
              $checkedConvert('new_scryfall_id', (v) => v as String?),
          note: $checkedConvert('note', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'performedAt': 'performed_at',
        'migrationStrategy': 'migration_strategy',
        'oldScryfallId': 'old_scryfall_id',
        'newScryfallId': 'new_scryfall_id'
      },
    );
