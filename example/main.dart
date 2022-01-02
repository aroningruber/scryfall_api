import 'package:scryfall_api/scryfall_api.dart';

/// Example usage of the Scryfall API wrapper.
void main() async {
  // Instantiate the Scyfall API Client.
  final apiClient = ScryfallApiClient();

  // Retrieve the [Adventures in the Forgotten Realms](https://scryfall.com/sets/afr)
  //set by its unique code (`afr`).
  final afrSet = await apiClient.getSetByCode('afr');

  // Print information about the set.
  print('Name of set: ${afrSet.name}');
  print('URI of set icon: ${afrSet.iconSvgUri}');
  print('Number of cards in set: ${afrSet.printedSize}');

  // Retrieve the 'Black Lotus' card by its name.
  final blackLotus = await apiClient.getCardByName('black lotus');

  // Print information about the card.
  print('Name of card: ${blackLotus.name}');
  print('Mana cost of card: ${blackLotus.manaCost}');
  print('Oracle text of card: ${blackLotus.oracleText}');

  // Close API Client when it's not used anymore.
  apiClient.close();
}
