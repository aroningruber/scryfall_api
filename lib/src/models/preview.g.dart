// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preview _$PreviewFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Preview',
      json,
      ($checkedConvert) {
        final val = Preview(
          previewedAt: $checkedConvert('previewed_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          sourceUri: $checkedConvert(
              'source_uri', (v) => v == null ? null : Uri.parse(v as String)),
          source: $checkedConvert('source', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'previewedAt': 'previewed_at',
        'sourceUri': 'source_uri'
      },
    );

Map<String, dynamic> _$PreviewToJson(Preview instance) => <String, dynamic>{
      if (instance.previewedAt?.toIso8601String() case final value?)
        'previewed_at': value,
      if (instance.sourceUri?.toString() case final value?) 'source_uri': value,
      if (instance.source case final value?) 'source': value,
    };
