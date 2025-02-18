import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'legalities.g.dart';

/// The legalities of a card accross various playing formats.
@JsonSerializable()
class Legalities {
  /// Standard playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality standard;

  /// Future playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality future;

  /// Historic playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality historic;

  /// Timeless playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality timeless;

  /// Gladiator playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality gladiator;

  /// Pioneer playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality pioneer;

  /// Explorer playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality explorer;

  /// Modern playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality modern;

  /// Legacy playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality legacy;

  /// Pauper playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality pauper;

  /// Vintage playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality vintage;

  /// Penny playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality penny;

  /// Commander playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality commander;

  /// Oathbreaker playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality oathbreaker;

  /// Brawl playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality brawl;

  /// Standard brawl playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality standardbrawl;

  /// Alchemy playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality alchemy;

  /// Pauper commander playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality paupercommander;

  /// Duel playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality duel;

  /// Old-school playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality oldschool;

  /// Pre-modern playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality premodern;

  /// PreDH playing format.
  @JsonKey(unknownEnumValue: Legality.unknown)
  final Legality predh;

  /// Constructs a [Legalities] object by setting its properties.
  const Legalities({
    required this.standard,
    required this.future,
    required this.historic,
    required this.timeless,
    required this.gladiator,
    required this.pioneer,
    required this.explorer,
    required this.modern,
    required this.legacy,
    required this.pauper,
    required this.vintage,
    required this.penny,
    required this.commander,
    required this.oathbreaker,
    required this.brawl,
    required this.standardbrawl,
    required this.alchemy,
    required this.paupercommander,
    required this.duel,
    required this.oldschool,
    required this.premodern,
    required this.predh,
  });

  /// Constructs a [Legalities] object from JSON.
  factory Legalities.fromJson(Map<String, dynamic> json) =>
      _$LegalitiesFromJson(json);

  Map<String, dynamic> toJson() => _$LegalitiesToJson(this);
}
