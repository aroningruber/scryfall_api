import 'package:json_annotation/json_annotation.dart';

part 'catalog.g.dart';

/// A [Catalog] object contains an array of Magic datapoints
/// (words, card values, etc).
///
/// [Catalog] objects are provided by the API as aids for
/// building other Magic software and understanding possible
/// values for a field on Card objects.
@JsonSerializable()
class Catalog {
  /// A link to the current catalog on Scryfall’s API.
  final Uri? uri;

  /// 	An array of datapoints.
  final List<String> data;

  /// Constructs a [Catalog] by settings its properties.
  const Catalog({
    this.uri,
    required this.data,
  });

  /// Constructs a [Catalog] from JSON.
  factory Catalog.fromJson(Map<String, dynamic> json) =>
      _$CatalogFromJson(json);

  /// Converts this [Catalog] to JSON.
  Map<String, dynamic> toJson() => _$CatalogToJson(this);

  /// The number of elements in this [Catalog].
  int get length => data.length;

  /// Returns the [index] element.
  String operator [](int index) => data[index];
}
