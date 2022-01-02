import 'package:scryfall_api/scryfall_api.dart';

/// Example usage of the Scryfall API wrapper.
void main() async {
  // Instantiate the Scyfall API Client.
  final apiClient = ScryfallApiClient();

  // Retrieve the [Adventures in the Forgotten Realms](https://scryfall.com/sets/afr)
  //set by its unique code (`afr`).
  final afrSet = await apiClient.getSetByCode('afr');

  // Print information about the set.
  print(afrSet.name);
  print(afrSet.iconSvgUri);
  print(afrSet.printedSize);

  // Retrieve the 'Black Lotus' card by its name.
  final blackLotus = await apiClient.getCardByName('black lotus');

  // Print information about the card.
  print(blackLotus.name);
  print(blackLotus.manaCost);
  print(blackLotus.oracleText);
}
