import 'package:http/http.dart' as http;
import 'package:scryfall_api/scryfall_api.dart';

/// Dart API Client that wraps the [Scryfall API](https://scryfall.com/).
class ScryfallApiClient {
  static const _baseUrl = 'api.scryfall.com';

  final http.Client _httpClient;

  ScryfallApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
}
