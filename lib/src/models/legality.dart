import 'package:json_annotation/json_annotation.dart';

/// The possible legalities of a card.
@JsonEnum(fieldRename: FieldRename.snake)
enum Legality {
  /// Card is legal.
  legal,

  /// Card is not legal.
  notLegal,

  /// The use of the card is restricted.
  restricted,

  /// The card is banned.
  banned,

  /// Unknown legality.
  unknown,
}
