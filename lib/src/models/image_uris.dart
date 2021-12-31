import 'package:json_annotation/json_annotation.dart';

part 'image_uris.g.dart';

/// [Uri]s for different resolutions of an image for a card.
@JsonSerializable()
class ImageUris {
  /// A small full card image.
  ///
  /// Designed for use as thumbnail or list icon.
  ///
  /// - Format: JPG
  /// - Size: 146 x 204
  final Uri small;

  /// A medium-sized full card image.
  ///
  /// - Format: JPG
  /// - Size: 488 × 680
  final Uri normal;

  /// A large full card image.
  ///
  /// - Format: JPG
  /// - Size: 672 × 936
  final Uri large;

  /// A transparent, rounded full card PNG.
  ///
  /// This is the best image to use for videos or
  /// other high-quality content.
  ///
  /// - Format: PNG
  /// - Size: 745 x 1040
  final Uri png;

  /// A rectangular crop of the card’s art only.
  ///
  /// Not guaranteed to be perfect for cards with
  /// outlier designs or strange frame arrangements.
  ///
  /// - Format: JPG
  /// - Size: Varies
  final Uri artCrop;

  /// A full card image with the rounded corners and
  /// the majority of the border cropped off.
  ///
  /// Designed for dated contexts where rounded images
  /// can’t be used.
  ///
  /// - Format: JPG
  /// - Size: 480 x 680
  final Uri borderCrop;

  /// Constructs an [ImageUris] object by settings its properties.
  const ImageUris({
    required this.small,
    required this.normal,
    required this.large,
    required this.png,
    required this.artCrop,
    required this.borderCrop,
  });

  /// Constructs an [ImageUris] object from JSON.
  factory ImageUris.fromJson(Map<String, dynamic> json) =>
      _$ImageUrisFromJson(json);
}
