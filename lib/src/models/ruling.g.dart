// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ruling _$RulingFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Ruling',
      json,
      ($checkedConvert) {
        final val = Ruling(
          oracleId: $checkedConvert('oracle_id', (v) => v as String),
          source: $checkedConvert(
              'source',
              (v) => $enumDecode(_$RulingSourceEnumMap, v,
                  unknownValue: RulingSource.unknown)),
          publishedAt: $checkedConvert(
              'published_at', (v) => DateTime.parse(v as String)),
          comment: $checkedConvert('comment', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'oracleId': 'oracle_id',
        'publishedAt': 'published_at'
      },
    );

const _$RulingSourceEnumMap = {
  RulingSource.scryfall: 'scryfall',
  RulingSource.wizardsOfTheCoast: 'wotc',
  RulingSource.unknown: 'unknown',
};
