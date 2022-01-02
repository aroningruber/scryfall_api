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
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          svgUri: $checkedConvert('svg_uri', (v) => Uri.parse(v as String)),
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

const _$ColorEnumMap = {
  Color.white: 'W',
  Color.blue: 'U',
  Color.black: 'B',
  Color.red: 'R',
  Color.green: 'G',
  Color.colorless: 'C',
  Color.unknown: 'unknown',
};
