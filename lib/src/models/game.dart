import 'package:json_annotation/json_annotation.dart';

/// The games a card may appear in.
@JsonEnum(fieldRename: FieldRename.snake)
enum Game {
  /// Cards printed on paper.
  paper,

  /// [MTG Arena](https://magic.wizards.com/de/mtgarena)
  arena,

  /// [MTG Online](https://magic.wizards.com/en/mtgo)
  mtgo,

  /// Unknown game.
  unknown,
}
