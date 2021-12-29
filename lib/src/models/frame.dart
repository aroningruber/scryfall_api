import 'package:json_annotation/json_annotation.dart';

/// The card frame used for the re/print in question.
///
/// The overall Magic frame has gone though several
/// major revisions in the game’s lifetime.
@JsonEnum(fieldRename: FieldRename.snake)
enum Frame {
  /// The original Magic card frame, starting from
  /// Limited Edition Alpha.
  @JsonValue('1993')
  classic_1993,

  /// The updated classic frame starting from Mirage block.
  @JsonValue('1997')
  classicUpdated_1997,

  /// The “modern” Magic card frame, introduced in
  /// Eighth Edition and Mirrodin block.
  @JsonValue('2003')
  modern_2003,

  /// The holofoil-stamp Magic card frame, introduced
  /// in Magic 2015.
  @JsonValue('2015')
  modernHoloFoilStamp_2015,

  /// The frame used on cards
  /// [from the future](http://mtgsalvation.gamepedia.com/Timeshifted#Timeshifted_in_Future_Sight).
  @JsonValue('future')
  future,

  /// Unknown frame.
  unknown,
}
