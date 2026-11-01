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
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
          jsonlDownloadUri: $checkedConvert(
              'jsonl_download_uri', (v) => Uri.parse(v as String)),
          compressedSize:
              $checkedConvert('compressed_size', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'updatedAt': 'updated_at',
        'jsonlDownloadUri': 'jsonl_download_uri',
        'compressedSize': 'compressed_size'
      },
    );

Map<String, dynamic> _$BulkDataToJson(BulkData instance) => <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri.toString(),
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'updated_at': instance.updatedAt.toIso8601String(),
      'jsonl_download_uri': instance.jsonlDownloadUri.toString(),
      'compressed_size': instance.compressedSize,
      'object': instance.object,
    };
