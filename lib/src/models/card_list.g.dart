// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardList _$CardListFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CardList',
      json,
      ($checkedConvert) {
        final val = CardList(
          notFound: $checkedConvert(
              'not_found',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => CardIdentifier.fromJson(e as Map<String, dynamic>))
                  .toList()),
          data: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => MtgCard.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'notFound': 'not_found'},
    );

Map<String, dynamic> _$CardListToJson(CardList instance) => <String, dynamic>{
      'not_found': instance.notFound,
      'data': instance.data,
    };
