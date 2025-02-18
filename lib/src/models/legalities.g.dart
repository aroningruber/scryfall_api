// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legalities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Legalities _$LegalitiesFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Legalities',
      json,
      ($checkedConvert) {
        final val = Legalities(
          standard: $checkedConvert(
              'standard',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          future: $checkedConvert(
              'future',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          historic: $checkedConvert(
              'historic',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          timeless: $checkedConvert(
              'timeless',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          gladiator: $checkedConvert(
              'gladiator',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          pioneer: $checkedConvert(
              'pioneer',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          explorer: $checkedConvert(
              'explorer',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          modern: $checkedConvert(
              'modern',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          legacy: $checkedConvert(
              'legacy',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          pauper: $checkedConvert(
              'pauper',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          vintage: $checkedConvert(
              'vintage',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          penny: $checkedConvert(
              'penny',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          commander: $checkedConvert(
              'commander',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          oathbreaker: $checkedConvert(
              'oathbreaker',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          brawl: $checkedConvert(
              'brawl',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          standardbrawl: $checkedConvert(
              'standardbrawl',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          alchemy: $checkedConvert(
              'alchemy',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          paupercommander: $checkedConvert(
              'paupercommander',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          duel: $checkedConvert(
              'duel',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          oldschool: $checkedConvert(
              'oldschool',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          premodern: $checkedConvert(
              'premodern',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
          predh: $checkedConvert(
              'predh',
              (v) => $enumDecode(_$LegalityEnumMap, v,
                  unknownValue: Legality.unknown)),
        );
        return val;
      },
    );

Map<String, dynamic> _$LegalitiesToJson(Legalities instance) =>
    <String, dynamic>{
      'standard': _$LegalityEnumMap[instance.standard]!,
      'future': _$LegalityEnumMap[instance.future]!,
      'historic': _$LegalityEnumMap[instance.historic]!,
      'timeless': _$LegalityEnumMap[instance.timeless]!,
      'gladiator': _$LegalityEnumMap[instance.gladiator]!,
      'pioneer': _$LegalityEnumMap[instance.pioneer]!,
      'explorer': _$LegalityEnumMap[instance.explorer]!,
      'modern': _$LegalityEnumMap[instance.modern]!,
      'legacy': _$LegalityEnumMap[instance.legacy]!,
      'pauper': _$LegalityEnumMap[instance.pauper]!,
      'vintage': _$LegalityEnumMap[instance.vintage]!,
      'penny': _$LegalityEnumMap[instance.penny]!,
      'commander': _$LegalityEnumMap[instance.commander]!,
      'oathbreaker': _$LegalityEnumMap[instance.oathbreaker]!,
      'brawl': _$LegalityEnumMap[instance.brawl]!,
      'standardbrawl': _$LegalityEnumMap[instance.standardbrawl]!,
      'alchemy': _$LegalityEnumMap[instance.alchemy]!,
      'paupercommander': _$LegalityEnumMap[instance.paupercommander]!,
      'duel': _$LegalityEnumMap[instance.duel]!,
      'oldschool': _$LegalityEnumMap[instance.oldschool]!,
      'premodern': _$LegalityEnumMap[instance.premodern]!,
      'predh': _$LegalityEnumMap[instance.predh]!,
    };

const _$LegalityEnumMap = {
  Legality.legal: 'legal',
  Legality.notLegal: 'not_legal',
  Legality.restricted: 'restricted',
  Legality.banned: 'banned',
  Legality.unknown: 'unknown',
};
