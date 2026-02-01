import 'package:json_annotation/json_annotation.dart';

import 'json_convert.dart';
import 'models.dart';

part 'mtg_card.g.dart';

/// [MtgCard] objects represent individual Magic: The Gathering
/// cards that players could obtain and add to their collection
/// (with a few minor exceptions).
///
/// Cards are the API’s most complex object. You are encouraged
/// to thoroughly read this document and also the article about
/// layouts and images.
///
/// ### Card Names
///
/// Internally, Scryfall tracks the uniqueness of “Oracle names.”
/// (i.e. names you can pick when an effect asks you to “choose a
/// card name”). Each unique Oracle name is separately available
/// in the card names catalog.
///
/// Note that while most Oracle card names are unique, Scryfall also
/// indexes other objects such as tokens and Unstable set variants
/// which do not always have a unique name.
///
/// ### Multiface Cards
///
/// Magic cards can have multiple faces or multiple cards printed
/// on one card stock. The faces could be shown divided on the
/// front of the card as in
/// [split cards](https://scryfall.com/search?q=is%3Asplit) and
/// [flip cards](https://scryfall.com/search?q=is%3Aflip), or the
/// card can be double-faced as in
/// [transform cards](https://scryfall.com/search?q=is%3Atransform)
/// and [modal DFCs](https://scryfall.com/search?q=is%3Amdfc).
///
/// Scryfall represents multi-face cards as a single object with
/// a card_faces array describing the distinct faces.
@JsonSerializable()
class MtgCard {
  /// This card’s Arena ID, if any.
  ///
  /// A large percentage of cards are not available on Arena
  /// and do not have this ID.
  final int? arenaId;

  /// A unique ID for this card in Scryfall’s database.
  final String id;

  /// A [language](https://scryfall.com/docs/api/languages)
  /// code for this printing.
  @JsonKey(unknownEnumValue: Language.unknown)
  final Language lang;

  /// This card’s Magic Online ID (also known as the Catalog ID),
  /// if any.
  ///
  /// A large percentage of cards are not available on Magic Online
  /// and do not have this ID.
  final int? mtgoId;

  /// This card’s foil Magic Online ID (also known as the Catalog ID),
  /// if any.
  ///
  /// A large percentage of cards are not available on Magic Online
  /// and do not have this ID.
  final int? mtgoFoilId;

  /// This card’s multiverse IDs on Gatherer, if any, as an array of integers.
  ///
  /// Note that Scryfall includes many promo cards, tokens, and other esoteric
  /// objects that do not have these identifiers.
  final List<int>? multiverseIds;

  /// This card’s ID on [TCGplayer’s API](https://docs.tcgplayer.com/docs),
  /// also known as the `productId`.
  final int? tcgplayerId;

  /// This card’s ID on [TCGplayer’s API](https://docs.tcgplayer.com/docs),
  /// for its etched version if that version is a separate product.
  final int? tcgplayerEtchedId;

  /// This card’s ID on Cardmarket’s API, also known as the `idProduct`.
  final int? cardmarketId;

  /// A unique ID for this card’s oracle identity.
  ///
  /// This value is consistent across reprinted card editions,
  /// and unique among different cards with the same name (tokens,
  /// Unstable variants, etc).
  @JsonKey(readValue: _readValueFromCardFaceIfReversibleCard)
  final String oracleId;

  /// A link to where you can begin paginating all re/prints for
  /// this card on Scryfall’s API.
  final Uri printsSearchUri;

  /// A link to this card’s [rulings list](https://scryfall.com/docs/api/rulings)
  /// on Scryfall’s API.
  final Uri rulingsUri;

  /// A link to this card’s permapage on Scryfall’s website.
  final Uri scryfallUri;

  /// A link to this card object on Scryfall’s API.
  final Uri uri;

  /// If this card is closely related to other cards,
  /// this property will be a [List] with [RelatedCard] Objects.
  final List<RelatedCard>? allParts;

  /// A [List] of [CardFace] objects, if this card is multifaced.
  final List<CardFace>? cardFaces;

  /// The card’s converted mana cost. Note that some funny cards
  /// have fractional mana costs.
  @JsonKey(readValue: _readValueFromCardFaceIfReversibleCard)
  final double cmc;

  /// This card’s color identity.
  @JsonKey(unknownEnumValue: Color.unknown)
  final List<Color> colorIdentity;

  /// The colors in this card’s color indicator, if any.
  ///
  /// A null value for this field indicates the card does not have one.
  @JsonKey(unknownEnumValue: Color.unknown)
  final List<Color>? colorIndicator;

  /// This card’s colors, if the overall card has colors defined
  /// by the rules.
  ///
  /// Otherwise the colors will be on the [cardFaces] objects.
  @JsonKey(unknownEnumValue: Color.unknown)
  final List<Color>? colors;

  /// This card’s overall rank/popularity on EDHREC.
  ///
  /// Not all cards are ranked.
  final int? edhrecRank;

  /// True if this card is on the [Commander Game Changer list](https://mtg.wiki/page/Commander_(format)/Game_Changers).
  final bool? gameChanger;

  /// This card’s hand modifier, if it is Vanguard card.
  ///
  /// This value will contain a delta, such as `-1`.
  final String? handModifier;

  /// A [List] of keywords that this card uses, such as
  /// `'Flying'` and `'Cumulative upkeep'`.
  final List<String> keywords;

  /// A code for this card’s [Layout].
  @JsonKey(unknownEnumValue: Layout.unknown)
  final Layout layout;

  /// An object describing the legality of this card across play formats.
  final Legalities legalities;

  /// This card’s life modifier, if it is Vanguard card.
  ///
  /// This value will contain a delta, such as `+2`.
  final String? lifeModifier;

  /// This loyalty if any.
  ///
  /// Note that some cards have loyalties that are not numeric,
  /// such as `X`.
  final String? loyalty;

  /// The mana cost for this card.
  ///
  /// This value will be any empty string `''` if the cost is absent.
  /// Remember that per the game rules, a missing mana cost and
  /// a mana cost of `{0}` are different values.
  /// Multi-faced cards will report this value in [cardFaces].
  final String? manaCost;

  /// The name of this card.
  ///
  /// If this card has multiple faces, this field will contain
  /// both names separated by ␣//␣.
  final String name;

  /// The Oracle text for this card, if any.
  final String? oracleText;

  /// This card’s rank/popularity on Penny Dreadful.
  ///
  /// Not all cards are ranked.
  final int? pennyRank;

  /// True if this card is oversized.
  final bool oversized;

  /// This card’s power, if any.
  ///
  /// Note that some cards have powers that are not numeric, such as `*`.
  final String? power;

  /// Colors of mana that this card could produce.
  @JsonKey(unknownEnumValue: Color.unknown)
  final List<Color>? producedMana;

  /// True if this card is on the Reserved List.
  final bool reserved;

  /// This card’s toughness, if any.
  ///
  /// Note that some cards have toughnesses that are not numeric, such as `*`.
  final String? toughness;

  /// The type line of this card.
  @JsonKey(readValue: _readValueFromCardFaceIfReversibleCard)
  final String typeLine;

  /// The name of the illustrator of this card.
  ///
  /// Newly spoiled cards may not have this field yet.
  final String? artist;

  /// The unique identifiers of the illustrators of this card.
  final List<String>? artistIds;

  /// The lit
  /// [Unfinity attractions](https://scryfall.com/search?q=t%3Aattraction+unique%3Aprints)
  /// lights on this card, if any.
  final List<int>? attractionLights;

  /// Whether this card is found in boosters.
  final bool booster;

  /// This card’s border color.
  @JsonKey(unknownEnumValue: BorderColor.unknown)
  final BorderColor borderColor;

  /// The Scryfall ID for the card back design present on this card, if any.
  final String? cardBackId;

  /// This card’s collector number.
  ///
  /// Note that collector numbers can contain non-numeric characters,
  /// such as letters or `★`.
  final String collectorNumber;

  /// True if you should consider
  /// [avoiding use of this print](https://scryfall.com/blog/220)
  /// downstream.
  final bool? contentWarning;

  /// True if this card was only released in a video game.
  final bool digital;

  /// True if the card exists in foil.
  final bool foil;

  /// True if the card exists in non-foil.
  final bool nonfoil;

  /// An array of computer-readable flags that indicate in which
  /// finishes this card can come in.
  @JsonKey(unknownEnumValue: Finish.unknown)
  final List<Finish> finishes;

  /// The just-for-fun name printed on the card
  /// (such as for Godzilla series cards).
  final String? flavorName;

  /// The flavor text, if any.
  final String? flavorText;

  /// This card’s [FrameEffect]s, if any.
  @JsonKey(unknownEnumValue: FrameEffect.unknown)
  final List<FrameEffect>? frameEffects;

  /// This card’s [Frame] layout.
  @JsonKey(unknownEnumValue: Frame.unknown)
  final Frame frame;

  /// True if this card’s artwork is larger than normal.
  final bool fullArt;

  /// A [List] of [Game]s that this card print is available in
  @JsonKey(unknownEnumValue: Game.unknown)
  final List<Game> games;

  /// True if this card’s imagery is high resolution.
  final bool highresImage;

  /// A unique identifier for the card artwork that remains
  /// consistent across reprints.
  ///
  /// Newly spoiled cards may not have this field yet.
  final String? illustrationId;

  /// A computer-readable indicator for the state of this card’s image.
  @JsonKey(unknownEnumValue: ImageStatus.unknown)
  final ImageStatus imageStatus;

  /// An object listing available imagery for this card
  final ImageUris? imageUris;

  /// An object containing daily price information for this card.
  final Prices prices;

  /// The localized name printed on this card, if any.
  final String? printedName;

  /// The localized text printed on this card, if any.
  final String? printedText;

  /// The localized type line printed on this card, if any.
  final String? printedTypeLine;

  /// True if this card is a promotional print.
  final bool promo;

  /// An array of strings describing what categories of
  /// promo cards this card falls into.
  final List<String>? promoTypes;

  /// An object providing URIs to this card’s listing on
  /// major marketplaces.
  final Map<String, Uri>? purchaseUris;

  /// This card’s rarity.
  @JsonKey(unknownEnumValue: Rarity.unknown)
  final Rarity rarity;

  /// An object providing URIs to this card’s listing on
  /// other _Magic: The Gathering_ online resources.
  final Map<String, Uri> relatedUris;

  /// The date this card was first released.
  @JsonKey(toJson: toDateString)
  final DateTime releasedAt;

  /// True if this card is a reprint.
  final bool reprint;

  /// A link to this card’s set on Scryfall’s website.
  final Uri scryfallSetUri;

  /// This card’s full set name.
  final String setName;

  /// A link to where you can begin paginating this card’s set
  /// on the Scryfall API.
  final Uri setSearchUri;

  /// The type of set this printing is in.
  @JsonKey(unknownEnumValue: SetType.unknown)
  final SetType setType;

  /// A link to this card’s [MtgSet] object on Scryfall’s API.
  final Uri setUri;

  /// This card’s set code.
  final String set;

  /// This card’s Set object UUID.
  final String setId;

  /// True if this card is a Story Spotlight.
  final bool storySpotlight;

  /// True if the card is printed without text.
  final bool textless;

  /// Whether this card is a variation of another printing.
  final bool variation;

  /// The printing ID of the printing this card is a variation of.
  final String? variationOf;

  /// The security stamp on this card, if any.
  @JsonKey(unknownEnumValue: SecurityStamp.unknown)
  final SecurityStamp? securityStamp;

  /// This card’s watermark, if any.
  final String? watermark;

  /// Information about when and where the card was first
  /// previewed, if any.
  final Preview? preview;

  /// Constructs a [MtgCard] by settings its properties.
  const MtgCard({
    this.arenaId,
    required this.id,
    required this.lang,
    this.mtgoId,
    this.mtgoFoilId,
    this.multiverseIds,
    this.tcgplayerId,
    this.tcgplayerEtchedId,
    this.cardmarketId,
    required this.oracleId,
    required this.printsSearchUri,
    required this.rulingsUri,
    required this.scryfallUri,
    required this.uri,
    this.allParts,
    this.cardFaces,
    required this.cmc,
    required this.colorIdentity,
    this.colorIndicator,
    this.colors,
    this.edhrecRank,
    this.gameChanger,
    this.handModifier,
    required this.keywords,
    required this.layout,
    required this.legalities,
    this.lifeModifier,
    this.loyalty,
    this.manaCost,
    required this.name,
    this.oracleText,
    this.pennyRank,
    required this.oversized,
    this.power,
    this.producedMana,
    required this.reserved,
    this.toughness,
    required this.typeLine,
    this.artist,
    this.artistIds,
    this.attractionLights,
    required this.booster,
    required this.borderColor,
    required this.cardBackId,
    required this.collectorNumber,
    required this.contentWarning,
    required this.digital,
    required this.foil,
    required this.nonfoil,
    required this.finishes,
    this.flavorName,
    this.flavorText,
    this.frameEffects,
    required this.frame,
    required this.fullArt,
    required this.games,
    required this.highresImage,
    this.illustrationId,
    required this.imageStatus,
    this.imageUris,
    required this.prices,
    this.printedName,
    this.printedText,
    this.printedTypeLine,
    required this.promo,
    this.promoTypes,
    required this.purchaseUris,
    required this.rarity,
    required this.relatedUris,
    required this.releasedAt,
    required this.reprint,
    required this.scryfallSetUri,
    required this.setName,
    required this.setSearchUri,
    required this.setType,
    required this.setUri,
    required this.set,
    required this.setId,
    required this.storySpotlight,
    required this.textless,
    required this.variation,
    this.variationOf,
    this.securityStamp,
    this.watermark,
    this.preview,
  });

  /// Constructs a [MtgCard] from JSON.
  factory MtgCard.fromJson(Map<String, dynamic> json) =>
      _$MtgCardFromJson(json);

  /// Constant discriminator for object type.
  @JsonKey(includeFromJson: false, includeToJson: true)
  String get object => 'card';

  // coverage:ignore-start
  @Deprecated(
    'Use `tcgplayerEtchedId` instead. Will be removed with version 3.0',
  )
  int? get tcgplyerEtchedId => tcgplayerEtchedId;

  @Deprecated(
    'Use `promoTypes` instead. Will be removed with version 3.0',
  )
  List<String>? get promoType => promoTypes;
  // coverage:ignore-end

  /// Converts a [MtgCard] to JSON.
  Map<String, dynamic> toJson() => _$MtgCardToJson(this);
}

Object? _readValueFromCardFaceIfReversibleCard(Map json, String name) {
  if (json.containsKey(name) ||
      json['layout'] != _$LayoutEnumMap[Layout.reversibleCard]) {
    return json[name];
  }

  final cardFaces = json['card_faces'];

  if (cardFaces is! List) {
    return null;
  }

  return cardFaces
      .cast<Map>()
      .map((cardFace) => cardFace[name])
      .toSet()
      .singleOrNull;
}
