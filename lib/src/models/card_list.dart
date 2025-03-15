import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'card_list.g.dart';

/// A list of cards returned by a **POST** /cards/collection request.
@JsonSerializable()
class CardList {
  /// A [List] of [CardIdentifier]s which could not be found.
  final List<CardIdentifier> notFound;

  /// A [List] of [MtgCard]s which could be uniquely identified
  /// by their [CardIdentifier]s.
  final List<MtgCard> data;

  /// Constructs a [CardList] by setting its properties.
  const CardList({
    required this.notFound,
    required this.data,
  });

  /// Constructs a [CardList] from JSON.
  factory CardList.fromJson(Map<String, dynamic> json) =>
      _$CardListFromJson(json);

  /// Converts this [CardList] to JSON.
  Map<String, dynamic> toJson() => _$CardListToJson(this);

  /// The number of objects in this list.
  int get length => data.length;

  /// Constant discriminator for object type.
  @JsonKey(includeFromJson: false, includeToJson: true)
  String get object => 'list';

  /// Returns the [index] element.
  MtgCard operator [](int index) => data[index];
}
