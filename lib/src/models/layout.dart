import 'package:json_annotation/json_annotation.dart';

/// The [Layout] categorizes the arrangement of card
/// parts, faces, and other bounded regions on cards.
/// The layout can be used to programmatically determine
/// which other properties on a card you can expect.
///
/// Specifically:
///
/// - Cards with the layouts split, flip, transform,
/// and double_faced_token will always have a `card_faces`
/// property describing the distinct faces.
/// - Cards with the layout meld will always have a
/// `related_cards` property pointing to the other
/// meld parts.
@JsonEnum(fieldRename: FieldRename.snake)
enum Layout {
  /// A standard Magic card with one face.
  normal,

  /// A split-faced card.
  split,

  /// Cards that invert vertically with the flip keyword.
  flip,

  /// Double-sided cards that transform.
  transform,

  /// Double-sided cards that can be played either-side.
  modalDfc,

  /// Cards with meld parts printed on the back.
  meld,

  /// Cards with Level Up.
  leveler,

  /// Class-type enchantment cards
  @JsonValue('class')
  clazz,

  /// Saga-type cards.
  saga,

  /// Cards with an Adventure spell part.
  adventure,

  /// Plane and Phenomenon-type cards.
  planar,

  /// Scheme-type cards.
  scheme,

  /// Vanguard-type cards.
  vanguard,

  /// Token cards.
  token,

  /// Tokens with another token printed on the back.
  doubleFacedToken,

  /// Emblem cards.
  emblem,

  /// Cards with Augment.
  augment,

  /// Host-type cards.
  host,

  /// Art Series collectable double-faced cards.
  artSeries,

  /// A Magic card with two sides that are unrelated.
  reversibleCard,

  /// Unknown layout.
  unknown,
}
