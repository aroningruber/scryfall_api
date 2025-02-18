// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatedCard _$RelatedCardFromJson(Map<String, dynamic> json) => $checkedCreate(
      'RelatedCard',
      json,
      ($checkedConvert) {
        final val = RelatedCard(
          id: $checkedConvert('id', (v) => v as String),
          component: $checkedConvert(
              'component', (v) => $enumDecode(_$ComponentEnumMap, v)),
          name: $checkedConvert('name', (v) => v as String),
          typeLine: $checkedConvert('type_line', (v) => v as String),
          uri: $checkedConvert('uri', (v) => Uri.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {'typeLine': 'type_line'},
    );

Map<String, dynamic> _$RelatedCardToJson(RelatedCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'component': _$ComponentEnumMap[instance.component]!,
      'name': instance.name,
      'type_line': instance.typeLine,
      'uri': instance.uri.toString(),
    };

const _$ComponentEnumMap = {
  Component.token: 'token',
  Component.meldPart: 'meld_part',
  Component.meldResult: 'meld_result',
  Component.comboPiece: 'combo_piece',
};
