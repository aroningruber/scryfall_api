import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'card_face.g.dart';

/// Multiface cards have a card_faces property containing at
/// least two Card Face objects.
@JsonSerializable()
class CardFace {
  /// The name of the illustrator of this card face.
  ///
  /// Newly spoiled cards may not have this field yet.
  final String? artist;

  /// The unique identifier of the illustraor of this card face.
  final String? artistId;

  /// The mana value of this particular face,
  /// if the card is reversible.
  final double? cmc;

  /// The colors in this face’s color indicator, if any.
  @JsonKey(unknownEnumValue: Color.unknown)
  final List<Color>? colorIndicator;

  /// This face’s colors, if the game defines colors
  /// for the individual face of this card.
  @JsonKey(unknownEnumValue: Color.unknown)
  final List<Color>? colors;

  /// The just-for-fun name printed on the card
  /// (such as for Godzilla series cards).
  final String? flavorName;

  /// The flavor text printed on this face, if any.
  final String? flavorText;

  /// A unique identifier for the card face artwork
  /// that remains consistent across reprints.
  ///
  /// Newly spoiled cards may not have this field yet.
  final String? illustrationId;

  /// An object providing URIs to imagery for this face,
  /// if this is a double-sided card.
  ///
  /// If this card is not double-sided, then the `image_uris`
  /// property will be part of the parent object instead.
  final ImageUris imageUris;

  /// The layout of this card face, if the card is reversible.
  final Layout? layout;

  /// This face’s loyalty, if any.
  final String? loyalty;

  /// The mana cost for this face.
  ///
  /// This value will be any empty string '' if the cost
  /// is absent. Remember that per the game rules, a
  /// missing mana cost and a mana cost of {0} are
  /// different values.
  final String manaCost;

  /// The name of this particular face.
  final String name;

  /// The Oracle ID of this particular face,
  /// if the card is reversible.
  final String? oracleId;

  /// The Oracle text for this face, if any.
  final String? oracleText;

  /// This face’s power, if any.
  ///
  /// Note that some cards have powers that are not numeric,
  /// such as `*`.
  final String? power;

  /// The localized name printed on this face, if any.
  final String? printedName;

  /// The localized text printed on this face, if any.
  final String? printedText;

  /// The localized type line printed on this face, if any.
  final String? printedTypeLine;

  /// This face’s toughness, if any.
  final String? toughness;

  /// The type line of this particular face,
  /// if the card is reversible.
  final String? typeLine;

  /// The watermark on this particulary card face, if any.
  final String? watermark;

  /// Constructs a [CardFace] by settings its properties.
  const CardFace({
    this.artist,
    this.artistId,
    this.cmc,
    this.colorIndicator,
    this.colors,
    this.flavorName,
    this.flavorText,
    this.illustrationId,
    required this.imageUris,
    this.layout,
    this.loyalty,
    required this.manaCost,
    required this.name,
    this.oracleId,
    this.oracleText,
    this.power,
    this.printedName,
    this.printedText,
    this.printedTypeLine,
    this.toughness,
    this.typeLine,
    this.watermark,
  });

  /// Constructs a [CardFace] from JSON.
  factory CardFace.fromJson(Map<String, dynamic> json) =>
      _$CardFaceFromJson(json);
}
