// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginable_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginableList<T> _$PaginableListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      'PaginableList',
      json,
      ($checkedConvert) {
        final val = PaginableList<T>(
          data: $checkedConvert(
              'data', (v) => (v as List<dynamic>).map(fromJsonT).toList()),
          hasMore: $checkedConvert('has_more', (v) => v as bool),
          nextPage: $checkedConvert(
              'next_page', (v) => v == null ? null : Uri.parse(v as String)),
          totalCards:
              $checkedConvert('total_cards', (v) => (v as num?)?.toInt()),
          warnings: $checkedConvert('warnings',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'hasMore': 'has_more',
        'nextPage': 'next_page',
        'totalCards': 'total_cards'
      },
    );

Map<String, dynamic> _$PaginableListToJson<T>(
  PaginableList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'has_more': instance.hasMore,
      if (instance.nextPage?.toString() case final value?) 'next_page': value,
      if (instance.totalCards case final value?) 'total_cards': value,
      if (instance.warnings case final value?) 'warnings': value,
      'object': instance.object,
    };
