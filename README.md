[![Pub Version](https://img.shields.io/pub/v/scryfall_api?style=for-the-badge)](https://pub.dev/packages/scryfall_api)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/aroningruber/scryfall_api/CI?logo=github&style=for-the-badge)](https://github.com/aroningruber/scryfall_api/actions)
[![Codecov](https://img.shields.io/codecov/c/gh/aroningruber/scryfall_api?logo=codecov&style=for-the-badge&token=D7LOCLLZC0)](https://codecov.io/gh/aroningruber/scryfall_api)

A wrapper of the [Scryfall API](https://scryfall.com) for the [Dart programming language](https://dart.dev/).

## Features

Query all information about [Magic: The Gathering](https://magic.wizards.com/)
which is provided by the [Scryfall API](https://scryfall.com):

- [Sets](https://scryfall.com/docs/api/sets)
- [Cards](https://scryfall.com/docs/api/cards) (_planned for v0.2.0_)
- [Rulings](https://scryfall.com/docs/api/rulings) (_planned for v0.3.0_)
- [Card Symbols](https://scryfall.com/docs/api/card-symbols) (_planned for v0.4.0_)
- [Catalogs](https://scryfall.com/docs/api/catalogs) (_planned for v0.5.0_)
- [Bulk data](https://scryfall.com/docs/api/bulk-data) (_planned for v0.6.0_)

## Installation

To install this package, just add the `scryfall_api` package to your `pubspec.yaml` file:

```yaml
dependencies:
    scryfall_api: ^0.1.0
```

Don't forget to install it by running `dart pub get` or `flutter pub get`.

After successfully installing the `scryfall_api` package, it can be imported with:

```dart
import 'package:scryfall_api/scryfall_api.dart';
```

## Usage

Retrieve the [Adventures in the Forgotten Realms](https://scryfall.com/sets/afr) set by its unique code (`afr`):

```dart
final client = ScryfallApiClient();

// [GET] https://api.scryfall.com/sets/afr
final afrSet = await client.getSetByCode('afr'); // MtgSet
afrSet.name // -> 'Adventures in the Forgotten Realms'
```

Retrieve a list of all sets:

```dart
final client = ScryfallApiClient();

// [GET] https://api.scryfall.com/sets
final allSets = await client.getAllSets(); // PaginableList<MtgSet>
```

## Features and bugs

If you encounter a bug or want to file a feature request, feel free to

- open a new [issue](https://github.com/aroningruber/scryfall_api/issues) or
- create a [pull request](https://github.com/aroningruber/scryfall_api/pulls).

## Disclaimer

[The Scryfall API package](https://pub.dev/packages/scryfall_api) is
unofficial Fan Content permitted under the Fan Content Policy. Not
approved/endorsed by Wizards. Portions of the materials used are property
of Wizards of the Coast. © Wizards of the Coast LLC.

All the information, literal and graphical, obtained from the [Scryfall API](https://scryfall.com) which is not © Wizards of the Coast LLC is © Scryfall LLC.
