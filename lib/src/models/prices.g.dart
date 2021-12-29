// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prices _$PricesFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Prices',
      json,
      ($checkedConvert) {
        final val = Prices(
          usd: $checkedConvert('usd', (v) => v as String?),
          usdFoil: $checkedConvert('usd_foil', (v) => v as String?),
          usdEtched: $checkedConvert('usd_etched', (v) => v as String?),
          eur: $checkedConvert('eur', (v) => v as String?),
          eurFoil: $checkedConvert('eur_foil', (v) => v as String?),
          tix: $checkedConvert('tix', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'usdFoil': 'usd_foil',
        'usdEtched': 'usd_etched',
        'eurFoil': 'eur_foil'
      },
    );
