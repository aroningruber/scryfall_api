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

  /// The URI that hosts this bulk file for fetching.
  final Uri downloadUri;

  /// The time when this file was last updated.
  final DateTime updatedAt;

  /// The size of this file in integer bytes.
  final int? size;

  /// The MIME type of this file.
  final String contentType;

  /// The Content-Encoding encoding that will be used to
  /// transmit this file when you download it.
  final String contentEncoding;

  /// Constructs a [BulkData] object by setting its properties.
  const BulkData({
    required this.id,
    required this.uri,
    required this.type,
    required this.name,
    required this.description,
    required this.downloadUri,
    required this.updatedAt,
    required this.size,
    required this.contentType,
    required this.contentEncoding,
  });

  /// Constructs a [BulkData] object from JSON.
  factory BulkData.fromJson(Map<String, dynamic> json) =>
      _$BulkDataFromJson(json);
}
