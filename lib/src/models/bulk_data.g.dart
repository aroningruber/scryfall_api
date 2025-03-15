// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkData _$BulkDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      'BulkData',
      json,
      ($checkedConvert) {
        final val = BulkData(
          id: $checkedConvert('id', (v) => v as String),
          uri: $checkedConvert('uri', (v) => Uri.parse(v as String)),
          type: $checkedConvert('type', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          downloadUri:
              $checkedConvert('download_uri', (v) => Uri.parse(v as String)),
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
          size: $checkedConvert('size', (v) => (v as num).toInt()),
          contentType: $checkedConvert('content_type', (v) => v as String),
          contentEncoding:
              $checkedConvert('content_encoding', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'downloadUri': 'download_uri',
        'updatedAt': 'updated_at',
        'contentType': 'content_type',
        'contentEncoding': 'content_encoding'
      },
    );

Map<String, dynamic> _$BulkDataToJson(BulkData instance) => <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri.toString(),
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'download_uri': instance.downloadUri.toString(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'size': instance.size,
      'content_type': instance.contentType,
      'content_encoding': instance.contentEncoding,
      'object': instance.object,
    };
