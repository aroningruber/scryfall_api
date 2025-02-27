import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'card_symbol.g.dart';

/// A [CardSymbol] object represents an illustrated symbol that
/// may appear in card’s mana cost or Oracle text.
///
/// Symbols are based on the notation used in the
/// [Comprehensive Rules](http://magic.wizards.com/en/game-info/gameplay/rules-and-formats/rules).
///
/// For more information about how the Scryfall API represents
/// mana and costs, see the
/// [colors and costs overview](https://scryfall.com/docs/api/colors).
@JsonSerializable()
class CardSymbol {
  /// The plaintext symbol.
  ///
  /// Often surrounded with curly braces `{}`. Note that not all symbols
  /// are ASCII text (for example, `{∞}`).
  final String symbol;

  /// An alternate version of this symbol, if it is possible to write
  /// it without curly braces.
  final String? looseVariant;

  /// An English snippet that describes this symbol.
  ///
  /// Appropriate for use in `alt` text or other
  /// accessible communication formats.
  final String english;

  /// True if it is possible to write this symbol “backwards”.
  ///
  /// For example, the official symbol `{U/P}` is sometimes written as
  /// `{P/U}` or `{P\U}` in informal settings. Note that the Scryfall API
  /// never writes symbols backwards in other responses. This field is
  /// provided for informational purposes.
  final bool transposable;

  /// True if this is a mana symbol.
  final bool representsMana;

  /// A decimal number representing this symbol’s converted mana cost.
  ///
  /// Note that mana symbols from funny sets can have fractional
  /// converted mana costs.
  final double? cmc;

  /// True if this symbol appears in a mana cost on any Magic card.
  ///
  /// For example `{20}` has this field set to false because `{20}`
  /// only appears in Oracle text, not mana costs.
  final bool appearsInManaCosts;

  /// True if this symbol is only used on funny cards or Un-cards.
  final bool funny;

  /// A [List] of colors that this symbol represents.
  final List<Color> colors;

  /// A [List] of plaintext versions of this symbol that Gatherer
  /// uses on old cards to describe original printed text.
  ///
  /// For example: `{W}` has ["oW", "ooW"] as alternates.
  final List<String>? gathererAlternates;

  /// A URI to an SVG image of this symbol on Scryfall’s CDNs.
  final Uri? svgUri;

  /// Constructs a [CardSymbol] by settings its properties.
  const CardSymbol({
    required this.symbol,
    this.looseVariant,
    required this.english,
    required this.transposable,
    required this.representsMana,
    this.cmc,
    required this.appearsInManaCosts,
    required this.funny,
    required this.colors,
    this.gathererAlternates,
    this.svgUri,
  });

  /// Constructs a [CardSymbol] from JSON.
  factory CardSymbol.fromJson(Map<String, dynamic> json) =>
      _$CardSymbolFromJson(json);

  /// Converts this [CardSymbol] to JSON.
  Map<String, dynamic> toJson() => _$CardSymbolToJson(this);
}
