import 'package:json_annotation/json_annotation.dart';

/// An exhaustive list of set types.
@JsonEnum(fieldRename: FieldRename.snake)
enum SetType {
  /// A yearly Magic core set (Tenth Edition, etc)
  core,

  /// A rotational expansion set in a block (Zendikar, etc)
  expansion,

  /// A reprint set that contains no new cards (Modern Masters, etc)
  masters,

  /// Masterpiece Series premium foil cards
  masterpiece,

  /// A Commander-oriented gift set
  arsenal,

  /// From the Vault gift sets
  fromTheVault,

  /// Spellbook series gift sets
  spellbook,

  /// Premium Deck Series decks
  premiumDeck,

  /// Duel Decks
  duelDeck,

  /// Special draft sets, like Conspiracy and Battlebond
  draftInnovation,

  /// Magic Online treasure chest prize sets
  treasureChest,

  /// Commander preconstructed decks
  commander,

  /// Planechase sets
  planechase,

  /// Archenemy sets
  archenemy,

  /// Vanguard card sets
  vanguard,

  /// A funny un-set or set with funny promos#
  /// (Unglued, Happy Holidays, etc)
  funny,

  /// A starter/introductory set (Portal, etc)
  starter,

  /// A gift box set
  box,

  /// A set that contains purely promotional cards
  promo,

  /// A set made up of tokens and emblems.
  token,

  /// A set made up of gold-bordered, oversize, or
  /// trophy cards that are not legal
  memorabilia,

  /// Unknown set type.
  unknown,
}
