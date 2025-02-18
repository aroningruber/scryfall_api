import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'mtg_set.g.dart';

/// A Set object represents a group of related Magic cards.
/// All Card objects on Scryfall belong to exactly one set.
///
/// Due to Magic’s long and complicated history, Scryfall
/// includes many un-official sets as a way to group promotional
/// or outlier cards together. Such sets will likely have a code
/// that begins with `p` or `t`, such as `pcel` or `tori`.
///
/// Official sets always have a three-letter set code, such as `zen`.
@JsonSerializable()
class MtgSet {
  /// A unique ID for this set on Scryfall that will not change.
  final String id;

  /// The unique three to five-letter code for this set.
  final String code;

  /// The unique code for this set on MTGO, which may differ from
  /// the regular code.
  final String? mtgoCode;

  /// The unique code for this set on Arena, which may differ from
  /// the regular code.
  final String? arenaCode;

  /// This set’s ID on [TCGplayer’s API](https://docs.tcgplayer.com/docs),
  /// also known as the groupId.
  final int? tcgplayerId;

  /// The English name of the set.
  final String name;
  @JsonKey(unknownEnumValue: SetType.unknown)

  /// A computer-readable classification for this set.
  final SetType setType;

  /// The date the set was released or the first card was printed
  /// in the set (in GMT-8 Pacific time).
  final DateTime? releasedAt;

  /// The block code for this set, if any.
  final String? blockCode;

  /// The block or group name code for this set, if any.
  final String? block;

  /// The set code for the parent set, if any. `promo` and `token`
  /// sets often have a parent set.
  final String? parentSetCode;

  /// The number of cards in this set.
  final int cardCount;

  /// The denominator for the set’s printed collector numbers.
  final int? printedSize;

  /// True if this set was only released in a video game.
  final bool digital;

  /// True if this set contains only foil cards.
  final bool foilOnly;

  /// True if this set contains only nonfoil cards.
  final bool nonfoilOnly;

  /// A link to this set’s permapage on Scryfall’s website.
  final Uri scryfallUri;

  /// A link to this set object on Scryfall’s API.
  final Uri uri;

  /// A URI to an SVG file for this set’s icon on Scryfall’s CDN.
  /// Hotlinking this image isn’t recommended, because it may change
  /// slightly over time. You should download it and use it locally
  /// for your particular user interface needs.
  final Uri iconSvgUri;

  /// A Scryfall API URI that you can request to begin paginating
  /// over the cards in this set.
  final Uri searchUri;

  /// Constructs a [MtgSet] by setting its properties.
  const MtgSet({
    required this.id,
    required this.code,
    this.mtgoCode,
    this.arenaCode,
    this.tcgplayerId,
    required this.name,
    required this.setType,
    this.releasedAt,
    this.blockCode,
    this.block,
    this.parentSetCode,
    required this.cardCount,
    this.printedSize,
    required this.digital,
    required this.foilOnly,
    required this.nonfoilOnly,
    required this.scryfallUri,
    required this.uri,
    required this.iconSvgUri,
    required this.searchUri,
  });

  /// Constructs a [MtgSet] from JSON.
  factory MtgSet.fromJson(Map<String, dynamic> json) => _$MtgSetFromJson(json);

  /// Converts this [MtgSet] to JSON.
  Map<String, dynamic> toJson() => _$MtgSetToJson(this);
}
