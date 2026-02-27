import 'package:json_annotation/json_annotation.dart';

/// The frame artwork applied over a particular frame.
///
/// For example, there are both 2003 and 2015-frame cards
/// with the Nyx-touched effect.
@JsonEnum(fieldRename: FieldRename.snake)
enum FrameEffect {
  /// The cards have a legendary crown.
  legendary,

  /// The miracle frame effect.
  miracle,

  /// The enchantment frame effect.
  enchantment,

  /// The draft-matters frame effect.
  draft,

  /// The Devoid frame effect.
  devoid,

  /// The Odyssey tombstone mark.
  tombstone,

  /// A colorshifted frame.
  colorshifted,

  /// The FNM-style inverted frame.
  inverted,

  /// The sun and moon transform marks.
  sunmoondfc,

  /// The compass and land transform marks.
  compasslanddfc,

  /// The Origins and planeswalker transform marks.
  originpwdfc,

  /// The moon and Eldrazi transform marks.
  mooneldrazidfc,

  /// The waxing and waning crescent moon transform marks.
  waxingandwaningmoondfc,

  /// A custom Showcase frame.
  showcase,

  /// An extended art frame.
  extendedart,

  /// The cards have a companion frame.
  companion,

  /// The cards have an etched foil treatment.
  etched,

  /// The cards have the snowy frame effect.
  snow,

  /// The cards have the Lesson frame effect.
  lesson,

  /// The cards have the Shattered Glass frame effect.
  shatteredglass,

  /// The cards have More Than Meets the Eye™ marks.
  convertdfc,

  /// The cards have fan transforming marks.
  fandfc,

  /// The cards have the Upside Down transforming marks.
  upsidedowndfc,

  /// The cards have Spree asterisks.
  spree,

  /// Unknown frame effect.
  unknown;

  // coverage:ignore-start
  @Deprecated('Use `enchantment` instead. Will be removed with version 3.0')
  static const nyxtouched = FrameEffect.enchantment;
  // coverage:ignore-end
}
