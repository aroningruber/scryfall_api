## 2.5.2

### Changed

- Added `User-Agent` and `Accept` headers to all HTTP requests. It is possible to override the `User-Agent` header when creating a `ScryfallApiClient`.

## 2.5.1

### Changed

- Cards with `layout == 'reversible_card'` do not expose `oracleId`, `cmc`, or `typeLine` at the top level; these fields are defined only on individual card faces. As the values are consistent across all faces, the top-level fields are now automatically populated from the corresponding card face values to preserve backward compatibility.

## 2.5.0

### Added

- Added `gameChanger` attribute to `MtgCard`.
- Added `pennyRank` attribute to `MtgCard`.

### Changed

- Fixed typo of `promoTypes` (previously `promoType`) of `MtgCard` class (thanks to [natebot13](https://github.com/natebot13)). *A deprecated getter with the name `promoType` is kept for backward compatibility.*

## 2.4.0

### Changed

- Added Quenya to `Language` enum.

## 2.3.0

### Changed

- Added default values to all attributes of `Legalities`.

## 2.2.0

### Added

- Added `toJson` methods to all model classes for JSON serialization (thanks to [Ichicoro](https://github.com/Ichicoro)).

### Changed

- Fixed typo of `tcgplayerEtchedId` (previously `tcgplyerEtchedId`) of `MtgCard` class. *A deprecated getter with the name `tcgplyerEtchedId` is kept for backward compatibility.*

## 2.1.0

### Added

- Added `defense` attribute to `CardFace` (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Added `shatteredglass`, `convertdfc`,`fandfc`, `upsidedowndfc` and `spree` to `FrameEffect` (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Added `case`, `mutate`, `prototype`, `battle` to `Layout` (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Added `attractionLights` attribute to `MtgCard` (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Added `circle` and `heart` to `SecurityStamp` (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Get super types (**GET** `/catalog/supertypes`) (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Get card types (**GET** `/catalog/card-types`) (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Get battle types (**GET** `/catalog/battle-types`) (thanks to [zmuranaka](https://github.com/zmuranaka)).
- Get flavor words (**GET** `/catalog/flavor-words`) (thanks to [zmuranaka](https://github.com/zmuranaka)).

## 2.0.0

### Changed

- Renamed `brawl` of `Legalities` to `standardbrawl` and `historicbrawl` of `Legalities` to `standardbrawl` (thanks to [Bassiuz](https://github.com/Bassiuz)).
- Added new formats `timeless`, `explorer`, `oathbreaker` and `predh` to `Legalities`.

### Removed

- Removed deprecated `compressedSize` getter from `BulkData`.

### Migration from 1.x

- The naming of Brawl formats has been changed in a backwards-incompatible way:
  - The `standardbrawl` format in `Legalities` was previously called `brawl`.
  - The `brawl` format in `Legalities` was previously called `historicbrawl`.

## 1.3.0

- Update SDK version to >=3.0

## 1.2.0

### Added

- Get card migrations (**GET** `/migrations`) (thanks to [PatrickWulfe](https://github.com/PatrickWulfe)).
- Get card migration by id (**GET** `/migrations/:id`) (thanks to [PatrickWulfe](https://github.com/PatrickWulfe)).

## 1.1.1

### Changed

- Renamed `compressedSize` of `BulkData` to `size` (thanks to [PatrickWulfe](https://github.com/PatrickWulfe)). *A deprecated getter with the name `compressedSize` is kept for backward compatibility.*

## 1.1.0

### Added

- Tests to ensure that bulk data methods properly decode response

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
