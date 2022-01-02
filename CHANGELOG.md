## 0.3.0

- Get rulings by multiverse id (**GET** `/cards/multiverse/:id/rulings`)
- Get rulings by mtgo id (**GET** `/cards/mtgo/:id/rulings`)
- Get rulings by arena id (**GET** `/cards/arena/:id/rulings`)
- Get rulings by set code and collector number (**GET** `/cards/:code/:number/rulings`)
- Get rulings by id (**GET** `/cards/:id/rulings`)

## 0.2.0

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

- Get all sets (**GET** `/sets`)
- Get a set by its unique code (**GET** `/sets/:code`)
- Get a set by its [TCGplayer's ID](https://docs.tcgplayer.com/docs) (**GET** `/sets/tcgplayer/:id`)
- Get a set by its id on [Srcyfall](https://scryfall.com/) (**GET** `sets/:id`)
