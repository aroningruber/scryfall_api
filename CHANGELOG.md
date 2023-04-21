## 1.1.1

### Changed

- Renamed `compressedSize` of `BulkDate` to `size` (thanks to [PatrickWulfe](https://github.com/PatrickWulfe)). *A deprecated getter with the name `compressedSize` is kept for backward compatibility*.

## 1.1.0

### Added

- Tests to ensure that bulk data methods property decode response

### Changed

- `purchaseUris` of `MtgCard` is nullable (thanks to [kalebhermes](https://github.com/kalebhermes))

## 1.0.0

### Added

- Get bulk data (**GET** `/bulk-data`)
- Get bulk data by id (**GET** `/bulk-data/:id`)
- Get bulk data by type (**GET** `/bulk-data/:type`)
- Get card names (**GET** `/catalog/card-names`)
- Get artist names (**GET** `/catalog/artist-names`)
- Get word bank (**GET** `/catalog/word-bank`)
- Get create types (**GET** `/catalog/creature-types`)
- Get planeswalker types (**GET** `/catalog/planeswalker-types`)
- Get land types (**GET** `/catalog/land-types`)
- Get artifact types (**GET** `/catalog/artifact-types`)
- Get enchantment types (**GET** `/catalog/enchantment-types`)
- Get spell types (**GET** `/catalog/spell-types`)
- Get powers (**GET** `/catalog/powers`)
- Get toughnesses (**GET** `/catalog/toughnesses`)
- Get loyalties (**GET** `/catalog/loyalties`)
- Get watermarks (**GET** `/catalog/watermarks`)
- Get keyword abilities (**GET** `/catalog/keyword-abilities`)
- Get keyword actions (**GET** `/catalog/keyword-actions`)
- Get ability words (**GET** `/catalog/ability-words`)

## 0.4.0

### Added

- Get all card symbols (**GET** `/symbology`)
- Parse mana cost (**GET** `/symbology/parse-mana`)

## 0.3.0

### Added

- Get rulings by multiverse id (**GET** `/cards/multiverse/:id/rulings`)
- Get rulings by mtgo id (**GET** `/cards/mtgo/:id/rulings`)
- Get rulings by arena id (**GET** `/cards/arena/:id/rulings`)
- Get rulings by set code and collector number (**GET** `/cards/:code/:number/rulings`)
- Get rulings by id (**GET** `/cards/:id/rulings`)

## 0.2.0

### Added

- Search for cards (**GET** `/cards/search`)
- Get card by name (**GET** `/cards/named`)
- Autocomplete card name (**GET** `/cards/autocomplete`)
- Get random card (**GET** `/cards/random`)
- Get cards by identifiers (**GET** `/cards/collection`)
- Get card by set code and collector number (**GET** `/cards/:code/:number(/:lang)`)
- Get card by multiverse id (**GET** `/cards/multiverse/:id`)
- Get card by mtgo id (**GET** `/cards/mtgo/:id`)
- Get card by arena id (**GET** `/cards/arena/:id`)
- Get card by tcgplayer id (**GET** `/cards/tcgplayer/:id`)
- Get card by cardmarket id (**GET** `/cards/cardmarket/:id`)
- Get card by id (**GET** `/cards/:id`)

## 0.1.0

### Added

- Get all sets (**GET** `/sets`)
- Get a set by its unique code (**GET** `/sets/:code`)
- Get a set by its [TCGplayer's ID](https://docs.tcgplayer.com/docs) (**GET** `/sets/tcgplayer/:id`)
- Get a set by its id on [Srcyfall](https://scryfall.com/) (**GET** `sets/:id`)
