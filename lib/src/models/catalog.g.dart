// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catalog _$CatalogFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Catalog',
      json,
      ($checkedConvert) {
        final val = Catalog(
          uri: $checkedConvert(
              'uri', (v) => v == null ? null : Uri.parse(v as String)),
          data: $checkedConvert('data',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$CatalogToJson(Catalog instance) => <String, dynamic>{
      'uri': instance.uri?.toString(),
      'data': instance.data,
      'object': instance.object,
    };
