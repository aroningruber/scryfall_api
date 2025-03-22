import 'package:json_annotation/json_annotation.dart';

import 'json_convert.dart';

part 'preview.g.dart';

/// Information about the preview of a card.
@JsonSerializable()
class Preview {
  /// The date this card was previewed.
  @JsonKey(toJson: toDateString)
  final DateTime? previewedAt;

  /// A link to the preview of this card.
  final Uri? sourceUri;

  /// The name of the source that previewed this card.
  final String? source;

  /// Constructs a [Preview] by setting its properties.
  const Preview({
    this.previewedAt,
    this.sourceUri,
    this.source,
  });

  /// Constructs a [Preview] from JSON.
  factory Preview.fromJson(Map<String, dynamic> json) =>
      _$PreviewFromJson(json);

  /// Converts this [Preview] to JSON.
  Map<String, dynamic> toJson() => _$PreviewToJson(this);
}
