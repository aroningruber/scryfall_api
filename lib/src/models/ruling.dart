import 'package:json_annotation/json_annotation.dart';

part 'ruling.g.dart';

/// [Ruling]s represent Oracle rulings, Wizards of the Coast
/// set release notes, or Scryfall notes for a particular card.
///
/// If two cards have the same name, they will have the same set
/// of rulings objects. If a card has rulings, it usually has
/// more than one.
///
/// Rulings with [RulingSource.scryfall] as [source] have been
/// added by the Scryfall team, either to provide additional
/// context for the card, or explain how the card works
/// in an unofficial format (such as Duel Commander).
@JsonSerializable()
class Ruling {
  /// The oracle id of the ruling.
  final String oracleId;

  /// The company which produced this ruling.
  @JsonKey(unknownEnumValue: RulingSource.unknown)
  final RulingSource source;

  /// The date when the ruling or note was published.
  final DateTime publishedAt;

  /// The text of the ruling.
  final String comment;

  /// Constructs a [Ruling] by setting its properties.
  const Ruling({
    required this.oracleId,
    required this.source,
    required this.publishedAt,
    required this.comment,
  });

  /// Constructs a [Ruling] from JSON.
  factory Ruling.fromJson(Map<String, dynamic> json) => _$RulingFromJson(json);

  /// Converts this [Ruling] to JSON.
  Map<String, dynamic> toJson() => _$RulingToJson(this);
}

/// The company which produced this ruling.
enum RulingSource {
  /// The ruling was added by the Scryfall team.
  scryfall,

  /// The ruling was added by Wizards of the Coast.
  @JsonValue('wotc')
  wizardsOfTheCoast,

  /// The source of the ruling is unknown.
  unknown,
}
