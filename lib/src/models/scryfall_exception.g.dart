// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scryfall_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScryfallException _$ScryfallExceptionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ScryfallException',
      json,
      ($checkedConvert) {
        final val = ScryfallException(
          status: $checkedConvert('status', (v) => (v as num).toInt()),
          code: $checkedConvert('code', (v) => v as String),
          details: $checkedConvert('details', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String?),
          warnings: $checkedConvert('warnings',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
    );
