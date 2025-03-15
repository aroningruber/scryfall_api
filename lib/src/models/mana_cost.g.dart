// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mana_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManaCost _$ManaCostFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ManaCost',
      json,
      ($checkedConvert) {
        final val = ManaCost(
          cost: $checkedConvert('cost', (v) => v as String),
          cmc: $checkedConvert('cmc', (v) => (v as num).toDouble()),
          colors: $checkedConvert(
              'colors',
              (v) => (v as List<dynamic>)
                  .map((e) => $enumDecode(_$ColorEnumMap, e))
                  .toList()),
          colorless: $checkedConvert('colorless', (v) => v as bool),
          monocolored: $checkedConvert('monocolored', (v) => v as bool),
          multicolored: $checkedConvert('multicolored', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ManaCostToJson(ManaCost instance) => <String, dynamic>{
      'cost': instance.cost,
      'cmc': instance.cmc,
      'colors': instance.colors.map((e) => _$ColorEnumMap[e]!).toList(),
      'colorless': instance.colorless,
      'monocolored': instance.monocolored,
      'multicolored': instance.multicolored,
      'object': instance.object,
    };

const _$ColorEnumMap = {
  Color.white: 'W',
  Color.blue: 'U',
  Color.black: 'B',
  Color.red: 'R',
  Color.green: 'G',
  Color.colorless: 'C',
  Color.unknown: 'unknown',
};
