import 'package:json_annotation/json_annotation.dart';

/// The colors used in [Magic: The Gathering](https://magic.wizards.com/).
enum Color {
  /// ![White Mana](https://c2.scryfall.com/file/scryfall-symbols/card-symbols/W.svg)
  @JsonValue('W')
  white,

  /// ![Blue Mana](https://c2.scryfall.com/file/scryfall-symbols/card-symbols/U.svg)
  @JsonValue('U')
  blue,

  /// ![Black Mana](https://c2.scryfall.com/file/scryfall-symbols/card-symbols/B.svg)
  @JsonValue('B')
  black,

  /// ![Red Mana](https://c2.scryfall.com/file/scryfall-symbols/card-symbols/R.svg)
  @JsonValue('R')
  red,

  /// ![Green Mana](https://c2.scryfall.com/file/scryfall-symbols/card-symbols/G.svg)
  @JsonValue('G')
  green,

  /// Unknown color
  unknown,
}
