import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'mana_cost.g.dart';

/// The result when requesting Scryfall to parse some mana.
@JsonSerializable()
class ManaCost {
  /// The normalized cost, with correctly-ordered
  /// and wrapped mana symbols.
  final String cost;

  /// The converted mana cost.
  ///
  /// If you submit Un-set mana symbols, this decimal could
  /// include fractional parts.
  final double cmc;

  /// The colors of the given cost.
  final List<Color> colors;

  /// True if the cost is colorless.
  final bool colorless;

  /// True if the cost is monocolored.
  final bool monocolored;

  /// True if the cost is multicolored.
  final bool multicolored;

  /// Constructs a [ManaCost] by setting its properties.
  const ManaCost({
    required this.cost,
    required this.cmc,
    required this.colors,
    required this.colorless,
    required this.monocolored,
    required this.multicolored,
  });

  /// Constructs a [ManaCost] from JSON.
  factory ManaCost.fromJson(Map<String, dynamic> json) =>
      _$ManaCostFromJson(json);

  /// Converts this [ManaCost] to JSON.
  Map<String, dynamic> toJson() => _$ManaCostToJson(this);
}
