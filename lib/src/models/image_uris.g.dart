// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_uris.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUris _$ImageUrisFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ImageUris',
      json,
      ($checkedConvert) {
        final val = ImageUris(
          small: $checkedConvert('small', (v) => Uri.parse(v as String)),
          normal: $checkedConvert('normal', (v) => Uri.parse(v as String)),
          large: $checkedConvert('large', (v) => Uri.parse(v as String)),
          png: $checkedConvert('png', (v) => Uri.parse(v as String)),
          artCrop: $checkedConvert('art_crop', (v) => Uri.parse(v as String)),
          borderCrop:
              $checkedConvert('border_crop', (v) => Uri.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {'artCrop': 'art_crop', 'borderCrop': 'border_crop'},
    );

Map<String, dynamic> _$ImageUrisToJson(ImageUris instance) => <String, dynamic>{
      'small': instance.small.toString(),
      'normal': instance.normal.toString(),
      'large': instance.large.toString(),
      'png': instance.png.toString(),
      'art_crop': instance.artCrop.toString(),
      'border_crop': instance.borderCrop.toString(),
    };
