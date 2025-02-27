import 'package:json_annotation/json_annotation.dart';

part 'paginable_list.g.dart';

/// A List object represents a requested sequence of other
/// objects (Cards, Sets, etc). List objects may be paginated,
/// and also include information about issues raised when
/// generating the list.
@JsonSerializable(genericArgumentFactories: true)
class PaginableList<T> {
  /// An array of the requested objects, in a specific order.
  final List<T> data;

  /// True if this List is paginated and there is a page
  /// beyond the current page.
  final bool hasMore;

  /// If there is a page beyond the current page, this field
  /// will contain a full API URI to that page. You may submit
  /// a HTTP `GET` request to that URI to continue paginating
  /// forward on this List.
  final Uri? nextPage;

  /// If this is a list of Card objects, this field will contain
  /// the total number of cards found across all pages.
  final int? totalCards;

  /// An array of human-readable warnings issued when generating
  /// this list, as strings. Warnings are non-fatal issues that
  /// the API discovered with your input. In general, they indicate
  /// that the List will not contain all of the information you
  /// requested. You should fix the warnings and re-submit your request.
  final List<String>? warnings;

  /// Constructs a [PaginableList] by setting its properties.
  PaginableList({
    required this.data,
    required this.hasMore,
    this.nextPage,
    this.totalCards,
    this.warnings,
  });

  /// Constructs a [PaginableList] from JSON.
  factory PaginableList.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PaginableListFromJson(json, fromJsonT);

  /// Converts this [PaginableList] to JSON.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      _$PaginableListToJson(this, toJsonT);

  /// The number of objects in this list.
  int get length => data.length;

  /// Returns the [index] element.
  T operator [](int index) => data[index];
}
