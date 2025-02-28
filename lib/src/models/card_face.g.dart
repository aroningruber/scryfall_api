// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_face.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardFace _$CardFaceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CardFace',
      json,
      ($checkedConvert) {
        final val = CardFace(
          artist: $checkedConvert('artist', (v) => v as String?),
          artistId: $checkedConvert('artist_id', (v) => v as String?),
          cmc: $checkedConvert('cmc', (v) => (v as num?)?.toDouble()),
          colorIndicator: $checkedConvert(
              'color_indicator',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$ColorEnumMap, e,
                      unknownValue: Color.unknown))
                  .toList()),
          colors: $checkedConvert(
              'colors',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$ColorEnumMap, e,
                      unknownValue: Color.unknown))
                  .toList()),
          defense: $checkedConvert('defense', (v) => v as String?),
          flavorName: $checkedConvert('flavor_name', (v) => v as String?),
          flavorText: $checkedConvert('flavor_text', (v) => v as String?),
          illustrationId:
              $checkedConvert('illustration_id', (v) => v as String?),
          imageUris: $checkedConvert(
              'image_uris',
              (v) => v == null
                  ? null
                  : ImageUris.fromJson(v as Map<String, dynamic>)),
          layout: $checkedConvert(
              'layout', (v) => $enumDecodeNullable(_$LayoutEnumMap, v)),
          loyalty: $checkedConvert('loyalty', (v) => v as String?),
          manaCost: $checkedConvert('mana_cost', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          oracleId: $checkedConvert('oracle_id', (v) => v as String?),
          oracleText: $checkedConvert('oracle_text', (v) => v as String?),
          power: $checkedConvert('power', (v) => v as String?),
          printedName: $checkedConvert('printed_name', (v) => v as String?),
          printedText: $checkedConvert('printed_text', (v) => v as String?),
          printedTypeLine:
              $checkedConvert('printed_type_line', (v) => v as String?),
          toughness: $checkedConvert('toughness', (v) => v as String?),
          typeLine: $checkedConvert('type_line', (v) => v as String?),
          watermark: $checkedConvert('watermark', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'artistId': 'artist_id',
        'colorIndicator': 'color_indicator',
        'flavorName': 'flavor_name',
        'flavorText': 'flavor_text',
        'illustrationId': 'illustration_id',
        'imageUris': 'image_uris',
        'manaCost': 'mana_cost',
        'oracleId': 'oracle_id',
        'oracleText': 'oracle_text',
        'printedName': 'printed_name',
        'printedText': 'printed_text',
        'printedTypeLine': 'printed_type_line',
        'typeLine': 'type_line'
      },
    );

Map<String, dynamic> _$CardFaceToJson(CardFace instance) => <String, dynamic>{
      'artist': instance.artist,
      'artist_id': instance.artistId,
      'cmc': instance.cmc,
      'color_indicator':
          instance.colorIndicator?.map((e) => _$ColorEnumMap[e]!).toList(),
      'colors': instance.colors?.map((e) => _$ColorEnumMap[e]!).toList(),
      'defense': instance.defense,
      'flavor_name': instance.flavorName,
      'flavor_text': instance.flavorText,
      'illustration_id': instance.illustrationId,
      'image_uris': instance.imageUris?.toJson(),
      'layout': _$LayoutEnumMap[instance.layout],
      'loyalty': instance.loyalty,
      'mana_cost': instance.manaCost,
      'name': instance.name,
      'oracle_id': instance.oracleId,
      'oracle_text': instance.oracleText,
      'power': instance.power,
      'printed_name': instance.printedName,
      'printed_text': instance.printedText,
      'printed_type_line': instance.printedTypeLine,
      'toughness': instance.toughness,
      'type_line': instance.typeLine,
      'watermark': instance.watermark,
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

const _$LayoutEnumMap = {
  Layout.normal: 'normal',
  Layout.split: 'split',
  Layout.flip: 'flip',
  Layout.transform: 'transform',
  Layout.modalDfc: 'modal_dfc',
  Layout.meld: 'meld',
  Layout.leveler: 'leveler',
  Layout.clazz: 'class',
  Layout.caze: 'case',
  Layout.saga: 'saga',
  Layout.adventure: 'adventure',
  Layout.mutate: 'mutate',
  Layout.prototype: 'prototype',
  Layout.battle: 'battle',
  Layout.planar: 'planar',
  Layout.scheme: 'scheme',
  Layout.vanguard: 'vanguard',
  Layout.token: 'token',
  Layout.doubleFacedToken: 'double_faced_token',
  Layout.emblem: 'emblem',
  Layout.augment: 'augment',
  Layout.host: 'host',
  Layout.artSeries: 'art_series',
  Layout.reversibleCard: 'reversible_card',
  Layout.unknown: 'unknown',
};
