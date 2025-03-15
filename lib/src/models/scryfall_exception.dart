import 'package:json_annotation/json_annotation.dart';

part 'scryfall_exception.g.dart';

/// A [ScryfallException] object represents a failure to find information
/// or understand the input you provided to the API.
/// [ScryfallException] objects are always transmitted with the
/// appropriate `4XX` or `5XX` HTTP status code.
@JsonSerializable()
class ScryfallException implements Exception {
  /// An integer HTTP status code for this error.
  final int status;

  /// A computer-friendly string representing the
  /// appropriate HTTP status code.
  final String code;

  /// A human-readable string explaining the error.
  final String details;

  /// A computer-friendly string that provides additional
  /// context for the main error. For example, an endpoint
  /// many generate `HTTP 404` errors for different kinds
  /// of input. This field will provide a label for the
  /// specific kind of 404 failure, such as `ambiguous`.
  final String? type;

  /// If your input also generated non-failure warnings,
  /// they will be provided as human-readable strings
  /// in this array.
  final List<String>? warnings;

  /// Constructs a [ScryfallException] by setting its properties.
  ScryfallException({
    required this.status,
    required this.code,
    required this.details,
    this.type,
    this.warnings,
  });

  /// Constructs a [ScryfallException] from JSON.
  factory ScryfallException.fromJson(Map<String, dynamic> json) =>
      _$ScryfallExceptionFromJson(json);

  /// Constant discriminator for object type.
  @JsonKey(includeFromJson: false, includeToJson: true)
  String get object => 'error';

  /// Converts this [ScryfallException] to JSON.
  Map<String, dynamic> toJson() => _$ScryfallExceptionToJson(this);
}
