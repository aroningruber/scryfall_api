import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scryfall_api/scryfall_api.dart';

/// Dart API Client that wraps the [Scryfall API](https://scryfall.com/).
class ScryfallApiClient {
  static const _baseUrl = 'api.scryfall.com';

  final http.Client _httpClient;

  ScryfallApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Returns a [List object][PaginableList] of all [Sets][MtgSet] on Scryfall.
  Future<PaginableList> getAllSets() async {
    final request = Uri.https(_baseUrl, '/sets');
    final response = await _httpClient.get(request);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList<MtgSet>.fromJson(
      json,
      (set) => MtgSet.fromJson(set as Map<String, dynamic>),
    );
  }
}
