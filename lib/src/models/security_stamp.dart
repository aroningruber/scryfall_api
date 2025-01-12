import 'package:json_annotation/json_annotation.dart';

/// The security stamp of a card.
@JsonEnum(fieldRename: FieldRename.snake)
enum SecurityStamp {
  /// Oval security stamp.
  oval,

  /// Triangle security stamp.
  triangle,

  /// Acorn security stamp.
  acorn,

  /// Circle security stamp.
  circle,

  /// Arena security stamp.
  arena,

  /// Heart security stamp.
  heart,

  /// Unknown security stamp.
  unknown,
}
