import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scryfall_api/scryfall_api.dart';

/// {@template scryfall_api_client}
/// Dart API Client that wraps the [Scryfall API](https://scryfall.com/).
/// {@endtemplate scryfall_api_client}
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
}
