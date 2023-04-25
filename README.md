[![Pub Version](https://img.shields.io/pub/v/scryfall_api?style=for-the-badge)](https://pub.dev/packages/scryfall_api)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/aroningruber/scryfall_api/ci.yml?branch=main&logo=github&style=for-the-badge)](https://github.com/aroningruber/scryfall_api/actions)
[![Codecov](https://img.shields.io/codecov/c/gh/aroningruber/scryfall_api?logo=codecov&style=for-the-badge&token=D7LOCLLZC0)](https://codecov.io/gh/aroningruber/scryfall_api)

A wrapper of the [Scryfall API](https://scryfall.com) for the [Dart programming language](https://dart.dev/).

## Features

Query all information about [Magic: The Gathering](https://magic.wizards.com/)
which is provided by the [Scryfall API](https://scryfall.com):

- [Sets](https://scryfall.com/docs/api/sets)
- [Cards](https://scryfall.com/docs/api/cards)
- [Rulings](https://scryfall.com/docs/api/rulings)
- [Card Symbols](https://scryfall.com/docs/api/card-symbols)
- [Catalogs](https://scryfall.com/docs/api/catalogs)
- [Bulk Data](https://scryfall.com/docs/api/bulk-data)
- [Card Migrations](https://scryfall.com/docs/api/migrations)

## Usage

Initialize the `ScryfallApiClient`:

```dart
final apiClient = ScryfallApiClient();
```

Retrieve the [Adventures in the Forgotten Realms](https://scryfall.com/sets/afr) set by its unique code (`afr`):

```dart
// [GET] https://api.scryfall.com/sets/afr
final afrSet = await apiClient.getSetByCode('afr');

afrSet.name // -> 'Adventures in the Forgotten Realms'

// Close API Client when it's not used anymore.
apiClient.close();
```

Retrieve the [Black Lotus](https://scryfall.com/card/vma/4/black-lotus) card by its `id` on [Scryfall](https://scryfall.com/):

```dart
// [GET] https://api.scryfall.com/cards/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd
final blackLotus = await apiClient.getCardById('bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd');

blackLotus.name       // -> 'Black Lotus'
blackLotus.oracleText // -> '{T}, Sacrifice Black Lotus: Add three mana of any one color.'

// Close API Client when it's not used anymore.
apiClient.close();
```

Retrieve all spell types from [Scryfall](https://scryfall.com/):

```dart
// [GET] https://api.scryfall.com/catalog/spell-types
final spellTypes = await apiClient.getSpellTypes();

spellTypes.length // -> 4
spellTypes.data   // -> [Adventure, Arcane, Lesson, Trap]
```

## Features and bugs

If you encounter a bug or want to file a feature request, feel free to

- open a new [issue](https://github.com/aroningruber/scryfall_api/issues) or
- create a [pull request](https://github.com/aroningruber/scryfall_api/pulls).

## Additional information

[The Scryfall API package](https://pub.dev/packages/scryfall_api) is
unofficial Fan Content permitted under the Fan Content Policy. Not
approved/endorsed by Wizards. Portions of the materials used are property
of Wizards of the Coast. © Wizards of the Coast LLC.

All the information, literal and graphical, obtained from the [Scryfall API](https://scryfall.com) which is not © Wizards of the Coast LLC is © Scryfall LLC.

The remaining part of this package is subject to its associated license.
