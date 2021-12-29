import 'package:json_annotation/json_annotation.dart';

/// The rarities of a card.
@JsonEnum(fieldRename: FieldRename.snake)
enum Rarity {
  /// Common rarity.
  common,

  /// Uncommon rarity.
  uncommon,

  /// Rare rarity.
  rare,

  /// Special rarity.
  special,

  /// Mythic rarity.
  mythic,

  /// Bonus rarity.
  bonus,

  /// Unknown rarity.
  unknown,
}
