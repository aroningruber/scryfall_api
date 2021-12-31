import 'package:json_annotation/json_annotation.dart';

/// A list of possible card finishes.
@JsonEnum(fieldRename: FieldRename.snake)
enum Finish {
  /// Foil card finish.
  foil,

  /// Non-foil card finish.
  nonfoil,

  /// Etched card finish.
  etched,

  /// Glossy card finish.
  glossy,

  /// Unknown card finish.
  unknown,
}
