import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:scryfall_api/scryfall_api.dart';
import 'package:scryfall_api/src/models/migration.dart';

/// {@template scryfall_api_client}
/// Dart API Client that wraps the [Scryfall API](https://scryfall.com/).
/// {@endtemplate}
class ScryfallApiClient {
  static const _baseUrl = 'api.scryfall.com';

  final http.Client _httpClient;

  /// {@macro scryfall_api_client}
  ScryfallApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Closes the connection to the Scryfall server.
  ///
  /// Any subsequent use of this instance is invalid
  /// and results in a [http.ClientException].
  ///
  /// This method closes the underlying [http.Client].
  /// Therefore, if a [http.Client] was provided when
  /// creating the [ScryfallApiClient], closing that
  /// [http.Client] is equivalent to calling this method.
  ///
  /// It's important to close each client when it's
  /// done being used; failing to do so can cause
  /// the Dart process to hang.
  void close() {
    _httpClient.close();
  }

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
      <String, String?>{
        'q': searchQuery,
        'unique': rollupMode?.name,
        'order': sortingOrder?.name,
        'dir': sortingDirection?.json,
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

  /// **GET** /cards/named
  ///
  /// Returns a Card based on a name search string. This method
  /// is designed for building chat bots, forum bots, and other
  /// services that need card details quickly.
  ///
  /// [name]\: The name to search for.
  ///
  /// [searchType]\: The type of search that shall be executed
  /// by the server. [SearchType.exact] performs a search that
  /// returns a card with the exact [name]. [SearchType.fuzzy]
  /// performs a fuzzy search.
  /// Defaults to [SearchType.exact].
  ///
  /// [set]\: A set code to limit the search to one set.
  Future<MtgCard> getCardByName(
    String name, {
    SearchType searchType = SearchType.exact,
    String? set,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/named',
      <String, String?>{
        'exact': searchType == SearchType.exact ? name : null,
        'fuzzy': searchType == SearchType.fuzzy ? name : null,
        'set': set,
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/named?format=image
  ///
  /// Returns an image of a Card based on a name search string.
  /// This method is designed for building chat bots, forum bots,
  /// and other services that need card details quickly.
  ///
  /// [name]\: The name to search for.
  ///
  /// [searchType]\: The type of search that shall be executed
  /// by the server. [SearchType.exact] performs a search that
  /// returns a card with the exact [name]. [SearchType.fuzzy]
  /// performs a fuzzy search.
  /// Defaults to [SearchType.exact].
  ///
  /// [set]\: A set code to limit the search to one set.
  ///
  /// {@template card_parameter_back_face}
  /// [backFace]\: If `true`, the back face of the card is returned.
  /// Will return a 422 if this card has no back face.
  /// Defaults to `false`.
  /// {@endtemplate}
  ///
  /// {@template card_parameter_image_version}
  /// [imageVersion]\: The version of the image that shall
  /// be returned.
  /// Defaults to [ImageVersion.large].
  /// {@endtemplate}
  Future<Uint8List> getCardByNameAsImage(
    String name, {
    SearchType searchType = SearchType.exact,
    String? set,
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/named',
      <String, String?>{
        'format': 'image',
        'exact': searchType == SearchType.exact ? name : null,
        'fuzzy': searchType == SearchType.fuzzy ? name : null,
        'set': set,
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/autocomplete
  ///
  /// Returns a [Catalog] object containing up to 20 full English
  /// card names that could be autocompletions of the given
  /// string parameter.
  ///
  /// This method is designed for creating assistive UI elements
  /// that allow users to free-type card names.
  ///
  /// The names are sorted with the nearest match first, highly
  /// favoring results that begin with your given string.
  ///
  /// Spaces, punctuation, and capitalization are ignored.
  ///
  /// If [query] is less than 2 characters long, or if no
  /// names match, the Catalog will contain 0 items (instead
  /// of returning any errors).
  ///
  /// [query]\: The query to autocomplete.
  ///
  /// [includeExtras]\: If true, extra cards (tokens, planes,
  /// vanguards, etc) will be included.
  /// Defaults to `false`.
  Future<Catalog> autocompleteCardName(
    String query, {
    bool? includeExtras,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/autocomplete',
      <String, String?>{
        'q': query,
        'include_extras': includeExtras?.toString(),
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return Catalog.fromJson(json);
  }

  /// **GET** /cards/random
  ///
  /// Returns a single random [MtgCard] object.
  ///
  /// [query]\: Is used to filter the possible cards
  /// and return a random card from the resulting pool
  /// of cards. Supports the same
  /// [fulltext search system](https://scryfall.com/docs/syntax)
  /// as the [main site](https://scryfall.com/).
  Future<MtgCard> getRandomCard({String? query}) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/random',
      <String, String?>{
        'q': query,
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/random?format=image
  ///
  /// Returns an image of a single random [MtgCard] object.
  ///
  /// [query]\: Is used to filter the possible cards
  /// and return a random card from the resulting pool
  /// of cards. Supports the same
  /// [fulltext search system](https://scryfall.com/docs/syntax)
  /// as the [main site](https://scryfall.com/).
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getRandomCardAsImage({
    String? query,
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/random',
      <String, String?>{
        'format': 'image',
        'q': query,
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **POST** /cards/collection
  ///
  /// Returns a [CardList] containing a [List] of [MtgCard]s
  /// identified by [identifiers].
  ///
  /// A maximum of 75 card references may be submitted per request.
  ///
  /// [identifiers]\: A [List] of [CardIdentifier]s.
  Future<CardList> getCardsByIdentifiers(
    List<CardIdentifier> identifiers,
  ) async {
    final url = Uri.https(_baseUrl, '/cards/collection');
    final body = jsonEncode({
      'identifiers': identifiers.map((i) => i.toJson()).toList(),
    });
    final response = await _httpClient.post(
      url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return CardList.fromJson(json);
  }

  /// **GET** /cards/:code/:number(/:lang)
  ///
  /// Returns a single card with the given
  /// [setCode] and [collectorNumber].
  ///
  /// {@template card_parameter_set_code}
  /// [setCode]\: The set code of the card.
  /// {@endtemplate}
  ///
  /// {@template card_parameter_collector_number}
  /// [collectorNumber]\: The collector number of the card.
  /// {@endtemplate}
  ///
  /// {@template card_parameter_language}
  /// [language]\: The language of the card.
  /// Defaults to [Language.english] (`en`).
  /// {@endtemplate}
  Future<MtgCard> getCardBySetCodeAndCollectorNumber(
    String setCode,
    String collectorNumber, {
    Language? language,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/$setCode/$collectorNumber${language != null ? '/${language.json}' : ''}',
    );
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/:code/:number(/:lang)?format=image
  ///
  /// Returns an image of a single card with the given
  /// [setCode] and [collectorNumber].
  ///
  /// {@macro card_parameter_set_code}
  ///
  /// {@macro card_parameter_collector_number}
  ///
  /// {@macro card_parameter_language}
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getCardBySetCodeAndCollectorNumberAsImage(
    String setCode,
    String collectorNumber, {
    Language? language,
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/$setCode/$collectorNumber${language != null ? '/${language.json}' : ''}',
      <String, String?>{
        'format': 'image',
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/multiverse/:id
  ///
  /// Returns a single card with the given [multiverseId].
  ///
  /// If the card has multiple multiverse IDs, this method can
  /// find either of them.
  Future<MtgCard> getCardByMultiverseId(int multiverseId) async {
    final url = Uri.https(_baseUrl, '/cards/multiverse/$multiverseId');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/multiverse/:id?format=image
  ///
  /// Returns an image of a single card with the given [multiverseId].
  ///
  /// If the card has multiple multiverse IDs, this method can
  /// find either of them.
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getCardByMultiverseIdAsImage(
    int multiverseId, {
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/multiverse/$multiverseId',
      <String, String?>{
        'format': 'image',
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      }..removeWhere((_, value) => value == null),
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/mtgo/:id
  ///
  /// Returns a single card with the given [mtgoId]
  /// (also known as the Catalog ID).
  ///
  /// The ID can either be the card’s `mtgo_id` or its `mtgo_foil_id`.
  Future<MtgCard> getCardByMtgoId(int mtgoId) async {
    final url = Uri.https(_baseUrl, '/cards/mtgo/$mtgoId');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/mtgo/:id?format=image
  ///
  /// Returns a single card with the given [mtgoId]
  /// (also known as the Catalog ID).
  ///
  /// The ID can either be the card’s `mtgo_id` or its `mtgo_foil_id`.
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getCardByMtgoIdAsImage(
    int mtgoId, {
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/mtgo/$mtgoId',
      <String, String?>{
        'format': 'image',
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      },
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/arena/:id
  ///
  /// Returns a single card with the given [arenaId]
  /// (Magic: The Gathering Arena ID).
  Future<MtgCard> getCardByArenaId(int arenaId) async {
    final url = Uri.https(_baseUrl, '/cards/arena/$arenaId');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/arena/:id?format=image
  ///
  /// Returns a single card with the given [arenaId]
  /// (Magic: The Gathering Arena ID).
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getCardByArenaIdAsImage(
    int arenaId, {
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/arena/$arenaId',
      <String, String?>{
        'format': 'image',
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      },
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/tcgplayer/:id
  ///
  /// Returns a single card with the given [tcgplayerId]
  /// or `tcgplayer_etched_id`, also known as the `productId`
  /// on [TCGplayer’s API](https://docs.tcgplayer.com/docs).
  Future<MtgCard> getCardByTcgplayerId(int tcgplayerId) async {
    final url = Uri.https(_baseUrl, '/cards/tcgplayer/$tcgplayerId');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/tcgplayer/:id?format=image
  ///
  /// Returns a single card with the given [tcgplayerId]
  /// or `tcgplayer_etched_id`, also known as the `productId`
  /// on [TCGplayer’s API](https://docs.tcgplayer.com/docs).
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getCardByTcgplayerIdAsImage(
    int tcgplayerId, {
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/tcgplayer/$tcgplayerId',
      <String, String?>{
        'format': 'image',
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      },
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/cardmarket/:id
  ///
  /// Returns a single card with the given [cardmarketId],
  /// also known as the `idProduct` or the Product ID on
  /// Cardmarket’s APIs.
  Future<MtgCard> getCardByCardmarketId(int cardmarketId) async {
    final url = Uri.https(_baseUrl, '/cards/cardmarket/$cardmarketId');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/cardmarket/:id?format=image
  ///
  /// Returns a single card with the given [cardmarketId],
  /// also known as the `idProduct` or the Product ID on
  /// Cardmarket’s APIs.
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getCardByCardmarketIdAsImage(
    int cardmarketId, {
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/cardmarket/$cardmarketId',
      <String, String?>{
        'format': 'image',
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      },
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/:id
  ///
  /// Returns a single card with the given [id] on Scryfall.
  Future<MtgCard> getCardById(String id) async {
    final url = Uri.https(_baseUrl, '/cards/$id');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return MtgCard.fromJson(json);
  }

  /// **GET** /cards/:id?format=image
  ///
  /// Returns a single card with the given [id] on Scryfall.
  ///
  /// {@macro card_parameter_back_face}
  ///
  /// {@macro card_parameter_image_version}
  Future<Uint8List> getCardByIdAsImage(
    String id, {
    bool? backFace,
    ImageVersion? imageVersion,
  }) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/$id',
      <String, String?>{
        'format': 'image',
        'face': backFace == true ? 'back' : null,
        'version': imageVersion?.json,
      },
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /cards/multiverse/:id/rulings
  ///
  /// Returns a [PaginableList] of [Ruling]s for a card with the
  /// given [multiverseId].
  ///
  /// If the card has multiple multiverse IDs, this method can
  /// find either of them.
  Future<PaginableList<Ruling>> getRulingsByMultiverseId(
    int multiverseId,
  ) async {
    final url = Uri.https(_baseUrl, '/cards/multiverse/$multiverseId/rulings');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList.fromJson(
      json,
      (ruling) => Ruling.fromJson(ruling as Map<String, dynamic>),
    );
  }

  /// **GET** /cards/mtgo/:id/rulings
  ///
  /// Returns a [PaginableList] of [Ruling]s for a card with the
  /// given [mtgoId].
  ///
  /// The [mtgoId] can either be the card’s `mtgo_id` or its `mtgo_foil_id`.
  Future<PaginableList<Ruling>> getRulingsByMtgoId(int mtgoId) async {
    final url = Uri.https(_baseUrl, '/cards/mtgo/$mtgoId/rulings');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList.fromJson(
      json,
      (ruling) => Ruling.fromJson(ruling as Map<String, dynamic>),
    );
  }

  /// **GET** /cards/arena/:id/rulings
  ///
  /// Returns a [PaginableList] of [Ruling]s for a card with the
  /// fiven [arenaId] (Magic: The Gathering Arena ID).
  Future<PaginableList<Ruling>> getRulingsByArenaId(int arenaId) async {
    final url = Uri.https(_baseUrl, '/cards/arena/$arenaId/rulings');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList.fromJson(
      json,
      (ruling) => Ruling.fromJson(ruling as Map<String, dynamic>),
    );
  }

  /// **GET** /cards/:code/:number/rulings
  ///
  /// Returns a [PaginableList] of [Ruling]s for a card with the
  /// given [setCode] and [collectorNumber].
  Future<PaginableList<Ruling>> getRulingsBySetCodeAndCollectorNumber(
    String setCode,
    String collectorNumber,
  ) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/$setCode/$collectorNumber/rulings',
    );
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList.fromJson(
      json,
      (ruling) => Ruling.fromJson(ruling as Map<String, dynamic>),
    );
  }

  /// **GET** /cards/:id/rulings
  ///
  /// Returns a [PaginableList] of [Ruling]s for a card with the
  /// given [id] on Scryfall.
  Future<PaginableList<Ruling>> getRulingsById(String id) async {
    final url = Uri.https(_baseUrl, '/cards/$id/rulings');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList.fromJson(
      json,
      (ruling) => Ruling.fromJson(ruling as Map<String, dynamic>),
    );
  }

  /// **GET** /symbology
  ///
  /// Returns a [PaginableList] of all [CardSymbol]s.
  Future<PaginableList<CardSymbol>> getAllCardSymbols() async {
    final url = Uri.https(_baseUrl, '/symbology');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList.fromJson(
      json,
      (cardSymbol) => CardSymbol.fromJson(cardSymbol as Map<String, dynamic>),
    );
  }

  /// **GET** /symbology/parse-mana
  ///
  /// Parses the given [manaCost] parameter
  /// and returns Scryfall’s interpretation.
  ///
  /// The server understands most community shorthand for
  /// mana costs (such as `2WW` for `{2}{W}{W}`). Symbols
  /// can also be out of order, lowercase, or have multiple
  /// colorless costs (such as `2{g}2` for `{4}{G}`).
  Future<ManaCost> parseMana(String manaCost) async {
    final url = Uri.https(
      _baseUrl,
      '/symbology/parse-mana',
      <String, String>{'cost': manaCost},
    );
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return ManaCost.fromJson(json);
  }

  /// **GET** /catalog/:catalog-type
  ///
  /// Returns a [Catalog] with a [List] of Magic datapoints.
  ///
  /// [catalogType]\: The type of catalog that shall be returned.
  Future<Catalog> getCatalog(CatalogType catalogType) async {
    final url = Uri.https(_baseUrl, '/catalog/${catalogType.urlEncoding}');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return Catalog.fromJson(json);
  }

  /// **GET** /catalog/card-names
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.cardNames].
  Future<Catalog> getCardNames() => getCatalog(CatalogType.cardNames);

  /// **GET** /catalog/artist-names
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.artistNames].
  Future<Catalog> getArtistNames() => getCatalog(CatalogType.artistNames);

  /// **GET** /catalog/word-bank
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.wordBank].
  Future<Catalog> getWordBank() => getCatalog(CatalogType.wordBank);

  /// **GET** /catalog/creature-types
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.creatureTypes].
  Future<Catalog> getCreatureTypes() => getCatalog(CatalogType.creatureTypes);

  /// **GET** /catalog/planeswalker-types
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.planeswalkerTypes].
  Future<Catalog> getPlaneswalkerTypes() =>
      getCatalog(CatalogType.planeswalkerTypes);

  /// **GET** /catalog/land-types
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.landTypes].
  Future<Catalog> getLandTypes() => getCatalog(CatalogType.landTypes);

  /// **GET** /catalog/artifact-types
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.artifactTypes].
  Future<Catalog> getArtifactTypes() => getCatalog(CatalogType.artifactTypes);

  /// **GET** /catalog/enchantment-types
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.enchantmentTypes].
  Future<Catalog> getEnchantmentTypes() =>
      getCatalog(CatalogType.enchantmentTypes);

  /// **GET** /catalog/spell-types
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.spellTypes].
  Future<Catalog> getSpellTypes() => getCatalog(CatalogType.spellTypes);

  /// **GET** /catalog/powers
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.powers].
  Future<Catalog> getPowers() => getCatalog(CatalogType.powers);

  /// **GET** /catalog/toughnesses
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.toughnesses].
  Future<Catalog> getToughnesses() => getCatalog(CatalogType.toughnesses);

  /// **GET** /catalog/loyalties
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.loyalties].
  Future<Catalog> getLoyalties() => getCatalog(CatalogType.loyalties);

  /// **GET** /catalog/watermarks
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.watermarks].
  Future<Catalog> getWatermarks() => getCatalog(CatalogType.watermarks);

  /// **GET** /catalog/keyword-abilities
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.keywordAbilities].
  Future<Catalog> getKeywordAbilities() =>
      getCatalog(CatalogType.keywordAbilities);

  /// **GET** /catalog/keyword-actions
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.keywordActions].
  Future<Catalog> getKeywordActions() => getCatalog(CatalogType.keywordActions);

  /// **GET** /catalog/ability-words
  ///
  /// Convenience method for calling [getCatalog]
  /// with [CatalogType.abilityWords].
  Future<Catalog> getAbilityWords() => getCatalog(CatalogType.abilityWords);

  /// **GET** /bulk-data
  ///
  /// Returns a [PaginableList] of all [BulkData] on Scryfall.
  Future<PaginableList<BulkData>> getBulkData() async {
    final url = Uri.https(_baseUrl, '/bulk-data');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList.fromJson(
      json,
      (bulkData) => BulkData.fromJson(bulkData as Map<String, dynamic>),
    );
  }

  /// **GET** /bulk-data/:id
  ///
  /// Returns a single [BulkData] object with the given [id].
  Future<BulkData> getBulkDataById(String id) async {
    final url = Uri.https(_baseUrl, '/bulk-data/$id');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return BulkData.fromJson(json);
  }

  /// **GET** /bulk-data/:id?format=file
  ///
  /// Returns the actual bulk data file with the given [id]
  /// as a [Uint8List].
  Future<Uint8List> getBulkDataByIdAsFile(String id) async {
    final url = Uri.https(_baseUrl, '/bulk-data/$id', {'format': 'file'});
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /bulk-data/:type
  ///
  /// Returns a single [BulkData] object with the given [type].
  Future<BulkData> getBulkDataByType(BulkDataType type) async {
    final url = Uri.https(_baseUrl, '/bulk-data/${type.urlEncoding}');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return BulkData.fromJson(json);
  }

  /// **GET** /bulk-data/:type?format=file
  ///
  /// Returns the actual bulk data file with the given [type]
  /// as a [Uint8List].
  Future<Uint8List> getBulkDataByTypeAsFile(BulkDataType type) async {
    final url = Uri.https(
      _baseUrl,
      '/bulk-data/${type.urlEncoding}',
      {'format': 'file'},
    );
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      throw ScryfallException.fromJson(json);
    }

    return response.bodyBytes;
  }

  /// **GET** /bulk-data/oracle-cards?format=file
  ///
  /// Convenience method for calling [getBulkDataByTypeAsFile]
  /// with [BulkDataType.oracleCards] and casting to correct type.
  Future<List<MtgCard>> getBulkDataOracleCards() async {
    final bytes = await getBulkDataByTypeAsFile(BulkDataType.oracleCards);

    final json = jsonDecode(utf8.decode(bytes)) as List<dynamic>;

    return json
        .map((card) => MtgCard.fromJson(card as Map<String, dynamic>))
        .toList();
  }

  /// **GET** /bulk-data/unique-artwork?format=file
  ///
  /// Convenience method for calling [getBulkDataByTypeAsFile]
  /// with [BulkDataType.uniqueArtwork] and casting to correct type.
  Future<List<MtgCard>> getBulkDataUniqueArtwork() async {
    final bytes = await getBulkDataByTypeAsFile(BulkDataType.uniqueArtwork);

    final json = jsonDecode(utf8.decode(bytes)) as List<dynamic>;

    return json
        .map((card) => MtgCard.fromJson(card as Map<String, dynamic>))
        .toList();
  }

  /// **GET** /bulk-data/default-cards?format=file
  ///
  /// Convenience method for calling [getBulkDataByTypeAsFile]
  /// with [BulkDataType.defaultCards] and casting to correct type.
  Future<List<MtgCard>> getBulkDataDefaultCards() async {
    final bytes = await getBulkDataByTypeAsFile(BulkDataType.defaultCards);

    final json = jsonDecode(utf8.decode(bytes)) as List<dynamic>;

    return json
        .map((card) => MtgCard.fromJson(card as Map<String, dynamic>))
        .toList();
  }

  /// **GET** /bulk-data/all-cards?format=file
  ///
  /// Convenience method for calling [getBulkDataByTypeAsFile]
  /// with [BulkDataType.allCards] and casting to correct type.
  Future<List<MtgCard>> getBulkDataAllCards() async {
    final bytes = await getBulkDataByTypeAsFile(BulkDataType.allCards);

    final json = jsonDecode(utf8.decode(bytes)) as List<dynamic>;

    return json
        .map((card) => MtgCard.fromJson(card as Map<String, dynamic>))
        .toList();
  }

  /// **GET** /bulk-data/rulings?format=file
  ///
  /// Convenience method for calling [getBulkDataByTypeAsFile]
  /// with [BulkDataType.rulings] and casting to correct type.
  Future<List<Ruling>> getBulkDataRulings() async {
    final bytes = await getBulkDataByTypeAsFile(BulkDataType.rulings);

    final json = jsonDecode(utf8.decode(bytes)) as List<dynamic>;

    return json
        .map((ruling) => Ruling.fromJson(ruling as Map<String, dynamic>))
        .toList();
  }

  /// **GET** /migrations
  ///
  /// Returns a [PaginableList] of all [Migration]s on Scryfall.
  Future<PaginableList<Migration>> getMigrations() async {
    final url = Uri.https(_baseUrl, '/migrations');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList<Migration>.fromJson(
      json,
      (migration) => Migration.fromJson(migration as Map<String, dynamic>),
    );
  }

  /// **GET** /migrations/:id
  ///
  /// Returns a [Migration] with the given id.
  Future<Migration> getMigration(String id) async {
    final url = Uri.https(_baseUrl, '/migrations/$id');
    final response = await _httpClient.get(url);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return Migration.fromJson(json);
  }
}

/// The types of [BulkData] which be retrieved.
enum BulkDataType {
  /// One Scryfall card object for each Oracle ID on Scryfall.
  oracleCards,

  /// Scryfall card objects that together contain all unique artworks.
  uniqueArtwork,

  /// Every card object on Scryfall in English or the printed language
  /// if the card is only available in one language.
  defaultCards,

  /// Every card object on Scryfall in every language.
  allCards,

  /// All Rulings on Scryfall.
  rulings,
}

extension on BulkDataType {
  String get urlEncoding {
    switch (this) {
      case BulkDataType.oracleCards:
        return 'oracle-cards';
      case BulkDataType.uniqueArtwork:
        return 'unique-artwork';
      case BulkDataType.defaultCards:
        return 'default-cards';
      case BulkDataType.allCards:
        return 'all-cards';
      case BulkDataType.rulings:
        return 'rulings';
    }
  }
}

/// The types of [Catalog] objects which can be retrieved
/// from Scryfall.
enum CatalogType {
  /// All nontoken English card names.
  cardNames,

  /// All canonical artist names.
  artistNames,

  /// All English words, of length 2 or more, that could
  /// appear in a card name.
  wordBank,

  /// All creature types.
  creatureTypes,

  /// All Planeswalker types.
  planeswalkerTypes,

  /// All Land types.
  landTypes,

  /// All artifact types.
  artifactTypes,

  /// All enchantment types.
  enchantmentTypes,

  /// All spell types.
  spellTypes,

  /// All possible values for a creature or vehicle’s power.
  powers,

  /// All possible values for a creature or vehicle’s toughness.
  toughnesses,

  /// All possible values for a Planeswalker’s loyalty.
  loyalties,

  /// All card watermarks.
  watermarks,

  /// All keyword abilities.
  keywordAbilities,

  /// All keyword actions.
  keywordActions,

  /// All ability words.
  abilityWords,
}

extension on CatalogType {
  String get urlEncoding {
    switch (this) {
      case CatalogType.cardNames:
        return 'card-names';
      case CatalogType.artistNames:
        return 'artist-names';
      case CatalogType.wordBank:
        return 'word-bank';
      case CatalogType.creatureTypes:
        return 'creature-types';
      case CatalogType.planeswalkerTypes:
        return 'planeswalker-types';
      case CatalogType.landTypes:
        return 'land-types';
      case CatalogType.artifactTypes:
        return 'artifact-types';
      case CatalogType.enchantmentTypes:
        return 'enchantment-types';
      case CatalogType.spellTypes:
        return 'spell-types';
      case CatalogType.powers:
        return 'powers';
      case CatalogType.toughnesses:
        return 'toughnesses';
      case CatalogType.loyalties:
        return 'loyalties';
      case CatalogType.watermarks:
        return 'watermarks';
      case CatalogType.keywordAbilities:
        return 'keyword-abilities';
      case CatalogType.keywordActions:
        return 'keyword-actions';
      case CatalogType.abilityWords:
        return 'ability-words';
    }
  }
}

/// The [ImageVersion] specifies the different resolutions and
/// versions of an image for a [MtgCard].
enum ImageVersion {
  /// A small full card image.
  ///
  /// Designed for use as thumbnail or list icon.
  ///
  /// - Format: JPG
  /// - Size: 146 x 204
  small,

  /// A medium-sized full card image.
  ///
  /// - Format: JPG
  /// - Size: 488 × 680
  normal,

  /// A large full card image.
  ///
  /// - Format: JPG
  /// - Size: 672 × 936
  large,

  /// A transparent, rounded full card PNG.
  ///
  /// This is the best image to use for videos or
  /// other high-quality content.
  ///
  /// - Format: PNG
  /// - Size: 745 x 1040
  png,

  /// A rectangular crop of the card’s art only.
  ///
  /// Not guaranteed to be perfect for cards with
  /// outlier designs or strange frame arrangements.
  ///
  /// - Format: JPG
  /// - Size: Varies
  artCrop,

  /// A full card image with the rounded corners and
  /// the majority of the border cropped off.
  ///
  /// Designed for dated contexts where rounded images
  /// can’t be used.
  ///
  /// - Format: JPG
  /// - Size: 480 x 680
  borderCrop,
}

extension on ImageVersion {
  String get json {
    switch (this) {
      case ImageVersion.small:
        return 'small';
      case ImageVersion.normal:
        return 'normal';
      case ImageVersion.large:
        return 'large';
      case ImageVersion.png:
        return 'png';
      case ImageVersion.artCrop:
        return 'art_crop';
      case ImageVersion.borderCrop:
        return 'border_crop';
    }
  }
}

/// The [SearchType] specifies the type of search that
/// shall be performed for searching by name.
enum SearchType {
  /// The exact card name to search for, case insenstive.
  exact,

  /// A fuzzy card name to search for.
  fuzzy,
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
  String get json {
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
