import 'package:json_annotation/json_annotation.dart';

/// The card's border color.
@JsonEnum(fieldRename: FieldRename.snake)
enum BorderColor {
  /// Black border color.
  black,

  /// White border color.
  white,

  /// No border color.
  borderless,

  /// Silver border color.
  silver,

  /// Golden border color.
  gold,

  /// Unknown border color.
  unknown,
}
