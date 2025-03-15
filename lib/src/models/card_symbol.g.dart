// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_symbol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardSymbol _$CardSymbolFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CardSymbol',
      json,
      ($checkedConvert) {
        final val = CardSymbol(
          symbol: $checkedConvert('symbol', (v) => v as String),
          looseVariant: $checkedConvert('loose_variant', (v) => v as String?),
          english: $checkedConvert('english', (v) => v as String),
          transposable: $checkedConvert('transposable', (v) => v as bool),
          representsMana: $checkedConvert('represents_mana', (v) => v as bool),
          cmc: $checkedConvert('cmc', (v) => (v as num?)?.toDouble()),
          appearsInManaCosts:
              $checkedConvert('appears_in_mana_costs', (v) => v as bool),
          funny: $checkedConvert('funny', (v) => v as bool),
          colors: $checkedConvert(
              'colors',
              (v) => (v as List<dynamic>)
                  .map((e) => $enumDecode(_$ColorEnumMap, e))
                  .toList()),
          gathererAlternates: $checkedConvert('gatherer_alternates',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          svgUri: $checkedConvert(
              'svg_uri', (v) => v == null ? null : Uri.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'looseVariant': 'loose_variant',
        'representsMana': 'represents_mana',
        'appearsInManaCosts': 'appears_in_mana_costs',
        'gathererAlternates': 'gatherer_alternates',
        'svgUri': 'svg_uri'
      },
    );

Map<String, dynamic> _$CardSymbolToJson(CardSymbol instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'loose_variant': instance.looseVariant,
      'english': instance.english,
      'transposable': instance.transposable,
      'represents_mana': instance.representsMana,
      'cmc': instance.cmc,
      'appears_in_mana_costs': instance.appearsInManaCosts,
      'funny': instance.funny,
      'colors': instance.colors.map((e) => _$ColorEnumMap[e]!).toList(),
      'gatherer_alternates': instance.gathererAlternates,
      'svg_uri': instance.svgUri?.toString(),
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
