import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum MigrationStrategy {
  /// A card is replaced with a new card.
  ///
  /// All references to the old card should be updated to the new card.
  merge,

  /// A card is removed without any replacement.
  ///
  /// All references to the old card should be invalided.
  delete,

  /// Unknown migration strategy.
  unknown,
}
