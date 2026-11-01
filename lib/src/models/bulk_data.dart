import 'package:json_annotation/json_annotation.dart';

part 'bulk_data.g.dart';

/// [BulkData] objects represent daily exports of Scryfall's
/// card data in bulk files.
@JsonSerializable()
class BulkData {
  /// A unique ID for this bulk item.
  final String id;

  /// The Scryfall API URI for this file.
  final Uri uri;

  /// A computer-readable string for the kind of bulk item.
  final String type;

  /// A human-readable name for this file.
  final String name;

  /// A human-readable description for this file.
  final String description;

  /// The time when this file was last updated.
  final DateTime updatedAt;

  /// The URI that hosts this bulk as jsonl.gz for fetching.
  final Uri jsonlDownloadUri;

  /// The size of the compressed jsonl.gz file in integer bytes.
  final int compressedSize;

  /// Constructs a [BulkData] object by setting its properties.
  const BulkData({
    required this.id,
    required this.uri,
    required this.type,
    required this.name,
    required this.description,
    required this.updatedAt,
    required this.jsonlDownloadUri,
    required this.compressedSize,
  });

  /// Constructs a [BulkData] object from JSON.
  factory BulkData.fromJson(Map<String, dynamic> json) =>
      _$BulkDataFromJson(json);

  /// Constant discriminator for object type.
  @JsonKey(includeFromJson: false, includeToJson: true)
  String get object => 'bulk_data';

  /// Converts this [BulkData] object to JSON.
  Map<String, dynamic> toJson() => _$BulkDataToJson(this);
}
