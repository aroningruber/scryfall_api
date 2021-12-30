import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scryfall_api/scryfall_api.dart';

/// {@template scryfall_api_client}
/// Dart API Client that wraps the [Scryfall API](https://scryfall.com/).
/// {@endtemplate}
class ScryfallApiClient {
  static const _baseUrl = 'api.scryfall.com';

  final http.Client _httpClient;

  /// {@macro scryfall_api_client}
  ScryfallApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// **GET** /sets
  ///
  /// Returns a [PaginableList] of all [MtgSet]s on Scryfall.
  Future<PaginableList<MtgSet>> getAllSets() async {
    final url = Uri.https(_baseUrl, '/sets');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList<MtgSet>.fromJson(
      json,
      (set) => MtgSet.fromJson(set as Map<String, dynamic>),
    );
  }

  /// **Get** /sets/:code
  ///
  /// Returns a [MtgSet] with the given set code.
  /// The [code] can be either the `code` or the `mtgo_code`
  /// for the set.
  Future<MtgSet> getSetByCode(String code) async {
    final url = Uri.https(_baseUrl, '/sets/$code');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgSet.fromJson(json);
  }

  /// **GET** /sets/tcgplayer/:id
  ///
  /// Returns a [MtgSet] with the given [tcgplayerId],
  /// also known as the `group_id` on
  /// [TCGPlayer's API](https://docs.tcgplayer.com/docs).
  Future<MtgSet> getSetByTcgplayerId(int tcgplayerId) async {
    final url = Uri.https(_baseUrl, '/sets/tcgplayer/$tcgplayerId');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgSet.fromJson(json);
  }

  /// **GET** /sets/:id
  ///
  /// Returns a [MtgSet] with the given [id].
  Future<MtgSet> getSetById(String id) async {
    final url = Uri.https(_baseUrl, '/sets/$id');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgSet.fromJson(json);
  }

  /// **GET** /cards/search
  ///
  ///
  /// Returns a [PaginableList] of all [MtgCard]s that match
  /// the specified [searchQuery] and additional arguments.
  /// The [searchQuery] uses the same
  /// [fulltext search system](https://scryfall.com/docs/syntax)
  /// as the [main site](https://scryfall.com/) uses.
  ///
  /// This method is paginated, returning 175 cards at a time.
  ///
  /// If only one card is found, this method will still
  /// return a [PaginableList].
  ///
  /// [searchQuery]\: A fulltext search query.
  /// Maximum length: 1000 Unicode characters.
  ///
  /// [rollupMode]\: The strategy for omitting similar cards.
  /// Defaults to [RollupMode.cards].
  ///
  /// [sortingOrder]\: The method to sort returned cards.
  /// Defaults to [SortingOrder.name].
  ///
  /// [sortingDirection]\: The direction to sort cards.
  /// Defaults to [SortingDirection.auto].
  ///
  /// [includeExtras]\: If true, extra cards (tokens, planes, etc)
  /// will be included. Equivalent to adding `include:extras` to
  /// the fulltext search.
  /// Defaults to `false`.
  ///
  /// [includeMultilingual]\: If true, cards in every language
  /// supported by Scryfall will be included.
  /// Defaults to `false`.
  ///
  /// [includeVariations]\: If true, rare care variants will be
  /// included, like the
  /// [Hairy Runesword](https://scryfall.com/card/drk/107%E2%80%A0/runesword).
  /// Defaults to `false`.
  ///
  /// [page]\: The page number to return.
  /// Defaults to `1`.
  Future<PaginableList<MtgCard>> searchCards(
    String searchQuery, {
    RollupMode? rollupMode,
    SortingOrder? sortingOrder,
    SortingDirection? sortingDirection,
    bool? includeExtras,
    bool? includeMultilingual,
    bool? includeVariations,
    int? page,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/search',
      {
        'q': searchQuery,
        'unique': rollupMode?.name,
        'order': sortingOrder?.name,
        'dir': sortingDirection?.name,
        'include_extras': includeExtras?.toString(),
        'include_multilingual': includeMultilingual?.toString(),
        'include_variations': includeVariations?.toString(),
        'page': page?.toString(),
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList<MtgCard>.fromJson(
      json,
      (card) => MtgCard.fromJson(card as Map<String, dynamic>),
    );
  }
}

/// The [RollupMode] specifies if Scryfall should remove
/// “duplicate” results in your query.
enum RollupMode {
  /// Removes duplicate gameplay objects (cards that share a name
  /// and have the same functionality).
  ///
  /// For example, if your search matches more than one print of
  /// Pacifism, only one copy of Pacifism will be returned.
  cards,

  /// Returns only one copy of each unique artwork for matching cards.
  ///
  /// For example, if your search matches more than one print of
  /// Pacifism, one card with each different illustration for Pacifism
  /// will be returned, but any cards that duplicate artwork already
  /// in the results will be omitted.
  art,

  /// Returns all prints for all cards matched (disables rollup).
  ///
  /// For example, if your search matches more than one print of Pacifism,
  /// all matching prints will be returned.
  prints,
}

/// The [SortingOrder] determines how Scryfall should sort the returned cards.
enum SortingOrder {
  /// Sort cards by name:
  /// A → Z.
  name,

  /// Sort cards by their set and collector number:
  /// AAA/#1 → ZZZ/#999.
  set,

  /// Sort cards by their release date:
  /// Newest → Oldest.
  released,

  /// Sort cards by their rarity:
  /// Common → Mythic.
  rarity,

  /// Sort cards by their color and color identity:
  /// WUBRG → multicolor → colorless.
  color,

  /// Sort cards by their lowest known U.S. Dollar price:
  /// 0.01 → highest, `null` last.
  usd,

  /// Sort cards by their lowest known TIX price:
  /// 0.01 → highest, `null` last.
  tix,

  /// Sort cards by their lowest known Euro price:
  /// 0.01 → highest, `null` last.
  eur,

  /// Sort cards by their converted mana cost:
  /// 0 → highest.
  cmc,

  /// Sort cards by their power:
  /// `null` → highest.
  power,

  /// Sort cards by their toughness:
  /// `null` → highest.
  toughness,

  /// Sort cards by their EDHREC ranking:
  /// lowest → highest.
  edhrec,

  /// Sort cards by their front-side artist name:
  /// A → Z.
  artist,

  /// Sort cards how podcasts review sets, usually color & CMC,
  /// lowest → highest, with Booster Fun cards at the end.
  review,
}

/// The [SortingDirection] specifies in which direction
/// the sorting should occur.
enum SortingDirection {
  /// Scryfall will automatically choose
  /// the most inuitive direction to sort.
  auto,

  /// Sort ascending (the direction of the arrows
  /// in the documentation of the [SortingOrder] values).
  ascending,

  /// Sort descending (flip the direction of the arrows
  /// in the documentation of the [SortingOrder] values).
  descending,
}

extension on SortingDirection {
  String get name {
    switch (this) {
      case SortingDirection.ascending:
        return 'asc';
      case SortingDirection.descending:
        return 'desc';
      default:
        return 'auto';
    }
  }
}
