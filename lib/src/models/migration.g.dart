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
          performedAt: $checkedConvert(
              'performed_at', (v) => DateTime.parse(v as String)),
          migrationStrategy: $checkedConvert(
              'migration_strategy',
              (v) => $enumDecode(_$MigrationStrategyEnumMap, v,
                  unknownValue: MigrationStrategy.unknown)),
          oldScryfallId: $checkedConvert('old_scryfall_id', (v) => v as String),
          newScryfallId:
              $checkedConvert('new_scryfall_id', (v) => v as String?),
          note: $checkedConvert('note', (v) => v as String?),
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

Map<String, dynamic> _$MigrationToJson(Migration instance) => <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      'performed_at': instance.performedAt.toIso8601String(),
      'migration_strategy':
          _$MigrationStrategyEnumMap[instance.migrationStrategy]!,
      'old_scryfall_id': instance.oldScryfallId,
      if (instance.newScryfallId case final value?) 'new_scryfall_id': value,
      if (instance.note case final value?) 'note': value,
      'object': instance.object,
    };

const _$MigrationStrategyEnumMap = {
  MigrationStrategy.merge: 'merge',
  MigrationStrategy.delete: 'delete',
  MigrationStrategy.unknown: 'unknown',
};
