import 'package:json_annotation/json_annotation.dart';

/// The status of the image data of a card.
@JsonEnum(fieldRename: FieldRename.snake)
enum ImageStatus {
  /// The card has no image, or the image is being
  /// processed. This value should only be temporary
  /// for very new cards.
  missing,

  /// Scryfall doesn’t have an image of this card,
  /// but we know it exists and we have uploaded a
  /// placeholder in the meantime. This value is
  /// most common on localized cards.
  placeholder,

  /// The card’s image is low-quality, either because
  /// it was just spoiled or we don’t have better
  /// photography for it yet.
  lowres,

  /// This card has a full-resolution scanner image.
  /// Crisp and glossy!
  highresScan,

  /// Unknown image status.
  unknown,
}
