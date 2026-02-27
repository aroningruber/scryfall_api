import 'package:json_annotation/json_annotation.dart';

/// The games a card may appear in.
@JsonEnum(fieldRename: FieldRename.snake)
enum Game {
  /// Cards printed on paper.
  paper,

  /// [MTG Arena](https://magic.wizards.com/en/mtgarena)
  arena,

  /// [MTG Online](https://magic.wizards.com/en/mtgo)
  mtgo,

  /// [Astral Cards](https://magic.wizards.com/en/news/feature/astral-cards-2009-02-12)
  astral,

  /// [Magic: the Gathering (Dreamcast)](https://mtg.fandom.com/wiki/Magic:_The_Gathering_(Dreamcast))
  sega,

  /// Unknown game.
  unknown,
}
