// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_identifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardIdentifierId _$CardIdentifierIdFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierId',
      json,
      ($checkedConvert) {
        final val = CardIdentifierId(
          $checkedConvert('id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$CardIdentifierIdToJson(CardIdentifierId instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CardIdentifierMtgoId _$CardIdentifierMtgoIdFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierMtgoId',
      json,
      ($checkedConvert) {
        final val = CardIdentifierMtgoId(
          $checkedConvert('mtgo_id', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'mtgoId': 'mtgo_id'},
    );

Map<String, dynamic> _$CardIdentifierMtgoIdToJson(
        CardIdentifierMtgoId instance) =>
    <String, dynamic>{
      'mtgo_id': instance.mtgoId,
    };

CardIdentifierMultiverseId _$CardIdentifierMultiverseIdFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierMultiverseId',
      json,
      ($checkedConvert) {
        final val = CardIdentifierMultiverseId(
          $checkedConvert('multiverse_id', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'multiverseId': 'multiverse_id'},
    );

Map<String, dynamic> _$CardIdentifierMultiverseIdToJson(
        CardIdentifierMultiverseId instance) =>
    <String, dynamic>{
      'multiverse_id': instance.multiverseId,
    };

CardIdentifierOracleId _$CardIdentifierOracleIdFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierOracleId',
      json,
      ($checkedConvert) {
        final val = CardIdentifierOracleId(
          $checkedConvert('oracle_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'oracleId': 'oracle_id'},
    );

Map<String, dynamic> _$CardIdentifierOracleIdToJson(
        CardIdentifierOracleId instance) =>
    <String, dynamic>{
      'oracle_id': instance.oracleId,
    };

CardIdentifierIllustrationId _$CardIdentifierIllustrationIdFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierIllustrationId',
      json,
      ($checkedConvert) {
        final val = CardIdentifierIllustrationId(
          $checkedConvert('illustration_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'illustrationId': 'illustration_id'},
    );

Map<String, dynamic> _$CardIdentifierIllustrationIdToJson(
        CardIdentifierIllustrationId instance) =>
    <String, dynamic>{
      'illustration_id': instance.illustrationId,
    };

CardIdentifierName _$CardIdentifierNameFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierName',
      json,
      ($checkedConvert) {
        final val = CardIdentifierName(
          $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$CardIdentifierNameToJson(CardIdentifierName instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

CardIdentifierSetName _$CardIdentifierSetNameFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierSetName',
      json,
      ($checkedConvert) {
        final val = CardIdentifierSetName(
          $checkedConvert('set', (v) => v as String),
          $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$CardIdentifierSetNameToJson(
        CardIdentifierSetName instance) =>
    <String, dynamic>{
      'set': instance.set,
      'name': instance.name,
    };

CardIdentifierSetCollectorNumber _$CardIdentifierSetCollectorNumberFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CardIdentifierSetCollectorNumber',
      json,
      ($checkedConvert) {
        final val = CardIdentifierSetCollectorNumber(
          $checkedConvert('set', (v) => v as String),
          $checkedConvert('collector_number', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'collectorNumber': 'collector_number'},
    );

Map<String, dynamic> _$CardIdentifierSetCollectorNumberToJson(
        CardIdentifierSetCollectorNumber instance) =>
    <String, dynamic>{
      'set': instance.set,
      'collector_number': instance.collectorNumber,
    };
