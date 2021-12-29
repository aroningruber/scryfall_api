import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('MtgCard', () {
    group('fromJson', () {
      test('returns correct MtgCard for single-faced card', () {
        final id = '1ebf9dea-b4f8-4955-9824-7da5bbba91e9';
        final oracle_id = '7d6c4290-d46d-4b98-805c-3f537462c4c8';
        final multiverse_ids = [];
        final mtgo_id = 65801;
        final name = 'Huang Zhong, Shu General';
        final lang = 'en';
        final released_at_str = '2016-11-16';
        final uri_str =
            'https://api.scryfall.com/cards/1ebf9dea-b4f8-4955-9824-7da5bbba91e9';
        final scryfall_uri_str =
            'https://scryfall.com/card/pz2/65801/huang-zhong-shu-general?utm_source=api';
        final layout_str = 'normal';
        final highres_image = false;
        final image_status_str = 'lowres';
        final image_uris = {
          'small':
              'https://c1.scryfall.com/file/scryfall-cards/small/front/1/e/1ebf9dea-b4f8-4955-9824-7da5bbba91e9.jpg?1562253415',
          'normal':
              'https://c1.scryfall.com/file/scryfall-cards/normal/front/1/e/1ebf9dea-b4f8-4955-9824-7da5bbba91e9.jpg?1562253415',
          'large':
              'https://c1.scryfall.com/file/scryfall-cards/large/front/1/e/1ebf9dea-b4f8-4955-9824-7da5bbba91e9.jpg?1562253415',
          'png':
              'https://c1.scryfall.com/file/scryfall-cards/png/front/1/e/1ebf9dea-b4f8-4955-9824-7da5bbba91e9.png?1562253415',
          'art_crop':
              'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/1/e/1ebf9dea-b4f8-4955-9824-7da5bbba91e9.jpg?1562253415',
          'border_crop':
              'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/1/e/1ebf9dea-b4f8-4955-9824-7da5bbba91e9.jpg?1562253415'
        };
        final mana_cost = '{2}{W}{W}';
        final cmc = 4;
        final type_line = 'Legendary Creature — Human Soldier';
        final oracle_text =
            'Huang Zhong, Shu General can\'t be blocked by more than one creature.';
        final power = '2';
        final toughness = '3';
        final colors_str = ['W'];
        final color_identity_str = ['W'];
        final color_indicator_str = ['W'];
        final keywords = [];
        final legalities = {
          'standard': 'not_legal',
          'future': 'not_legal',
          'historic': 'not_legal',
          'gladiator': 'not_legal',
          'pioneer': 'not_legal',
          'modern': 'not_legal',
          'legacy': 'legal',
          'pauper': 'not_legal',
          'vintage': 'legal',
          'penny': 'not_legal',
          'commander': 'legal',
          'brawl': 'not_legal',
          'historicbrawl': 'not_legal',
          'alchemy': 'not_legal',
          'paupercommander': 'not_legal',
          'duel': 'legal',
          'oldschool': 'not_legal',
          'premodern': 'not_legal'
        };
        final games_str = ['mtgo'];
        final reserved = false;
        final foil = true;
        final nonfoil = true;
        final finishes_str = ['nonfoil', 'foil'];
        final oversized = false;
        final promo = false;
        final reprint = true;
        final variation = false;
        final set_id = '2661b143-8eac-4c73-9d93-549fe928bd96';
        final set = 'pz2';
        final set_name = 'Treasure Chest';
        final set_type_str = 'treasure_chest';
        final set_uri_str =
            'https://api.scryfall.com/sets/2661b143-8eac-4c73-9d93-549fe928bd96';
        final set_search_uri_str =
            'https://api.scryfall.com/cards/search?order=set&q=e%3Apz2&unique=prints';
        final scryfall_set_uri_str =
            'https://scryfall.com/sets/pz2?utm_source=api';
        final rulings_uri_str =
            'https://api.scryfall.com/cards/1ebf9dea-b4f8-4955-9824-7da5bbba91e9/rulings';
        final prints_search_uri_str =
            'https://api.scryfall.com/cards/search?order=released&q=oracleid%3A7d6c4290-d46d-4b98-805c-3f537462c4c8&unique=prints';
        final collector_number = '65801';
        final digital = true;
        final rarity_str = 'rare';
        final flavor_text =
            '\'Virile in war, he kept the north in fear; His prodigies subdued the western sphere.\'';
        final card_back_id = '0aeebaf5-8c7d-4636-9e82-8c27447861f7';
        final artist = 'Quan Xuejun';
        final artist_ids = ['0dee7feb-9e78-4d1b-9458-52c8cb7ad078'];
        final illustration_id = '8e729a46-ab8b-411c-9cef-8f4a7b67beca';
        final border_color_str = 'black';
        final frame_str = '2015';
        final security_stamp_str = 'oval';
        final full_art = false;
        final textless = false;
        final booster = false;
        final story_spotlight = false;
        final edhrec_rank = 21021;
        final prices = {
          'usd': null,
          'usd_foil': null,
          'usd_etched': null,
          'eur': null,
          'eur_foil': null,
          'tix': '1.10'
        };
        final related_uris = {
          'tcgplayer_infinite_articles':
              'https://infinite.tcgplayer.com/search?contentMode=article&game=magic&partner=scryfall&q=Huang+Zhong%2C+Shu+General&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
          'tcgplayer_infinite_decks':
              'https://infinite.tcgplayer.com/search?contentMode=deck&game=magic&partner=scryfall&q=Huang+Zhong%2C+Shu+General&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
          'edhrec': 'https://edhrec.com/route/?cc=Huang+Zhong%2C+Shu+General',
          'mtgtop8':
              'https://mtgtop8.com/search?MD_check=1&SB_check=1&cards=Huang+Zhong%2C+Shu+General'
        };
        final purchase_uris = {
          'tcgplayer':
              'https://www.tcgplayer.com/search/magic/product?productLineName=magic&q=Huang+Zhong%2C+Shu+General&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
          'cardmarket':
              'https://www.cardmarket.com/en/Magic/Products/Search?referrer=scryfall&searchString=Huang+Zhong%2C+Shu+General&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall',
          'cardhoarder':
              'https://www.cardhoarder.com/cards/65801?affiliate_id=scryfall&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall'
        };
        final preview = {
          'source': 'Sjow',
          'source_uri':
              'https://twitter.com/LiquidSjow/status/1211727247247388672?s=19',
          'previewed_at': '2019-12-30',
        };
        final all_parts = [
          {
            "object": "related_card",
            "id": "1ce91e38-4601-4354-ad1b-2c5c1c70da17",
            "component": "combo_piece",
            "name": "Ruthless Knave",
            "type_line": "Creature — Orc Pirate",
            "uri":
                "https://api.scryfall.com/cards/1ce91e38-4601-4354-ad1b-2c5c1c70da17"
          },
          {
            "object": "related_card",
            "id": "720f3e68-84c0-462e-a0d1-90236ccc494a",
            "component": "token",
            "name": "Treasure",
            "type_line": "Token Artifact — Treasure",
            "uri":
                "https://api.scryfall.com/cards/720f3e68-84c0-462e-a0d1-90236ccc494a"
          },
        ];
        final card_faces = [
          {
            "object": "card_face",
            "name": "Professor of Zoomancy",
            "mana_cost": "",
            "type_line": "Card",
            "oracle_text": "",
            "colors": [],
            "artist": "Rudy Siswanto",
            "artist_id": "23f86db1-9103-49bb-83d5-0fda18143921",
            "illustration_id": "45d02cb9-5ce4-43ef-9a02-5f1e470e153d",
            "image_uris": {
              "small":
                  "https://c1.scryfall.com/file/scryfall-cards/small/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "normal":
                  "https://c1.scryfall.com/file/scryfall-cards/normal/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "large":
                  "https://c1.scryfall.com/file/scryfall-cards/large/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "png":
                  "https://c1.scryfall.com/file/scryfall-cards/png/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.png?1619463614",
              "art_crop":
                  "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "border_crop":
                  "https://c1.scryfall.com/file/scryfall-cards/border_crop/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614"
            }
          },
          {
            "object": "card_face",
            "name": "Professor of Zoomancy",
            "flavor_name": "",
            "mana_cost": "",
            "type_line": "Card",
            "oracle_text": "",
            "colors": [],
            "artist": "Rudy Siswanto",
            "artist_id": "23f86db1-9103-49bb-83d5-0fda18143921",
            "illustration_id": "9f59e837-24dd-47ad-83d0-f3ec4b290963",
            "image_uris": {
              "small":
                  "https://c1.scryfall.com/file/scryfall-cards/small/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "normal":
                  "https://c1.scryfall.com/file/scryfall-cards/normal/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "large":
                  "https://c1.scryfall.com/file/scryfall-cards/large/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "png":
                  "https://c1.scryfall.com/file/scryfall-cards/png/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.png?1619463614",
              "art_crop":
                  "https://c1.scryfall.com/file/scryfall-cards/art_crop/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614",
              "border_crop":
                  "https://c1.scryfall.com/file/scryfall-cards/border_crop/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614"
            },
          }
        ];
        final produced_mana_str = ["C", "G"];
        final frame_effects_str = ["legendary"];

        final json = <String, dynamic>{
          'object': 'card',
          'id': id,
          'oracle_id': oracle_id,
          'multiverse_ids': multiverse_ids,
          'mtgo_id': mtgo_id,
          'name': name,
          'lang': lang,
          'released_at': released_at_str,
          'uri': uri_str,
          'scryfall_uri': scryfall_uri_str,
          'layout': layout_str,
          'highres_image': highres_image,
          'image_status': image_status_str,
          'image_uris': image_uris,
          'mana_cost': mana_cost,
          'cmc': cmc,
          'type_line': type_line,
          'oracle_text': oracle_text,
          'power': power,
          'toughness': toughness,
          'colors': colors_str,
          'color_identity': color_identity_str,
          'color_indicator': color_indicator_str,
          'keywords': keywords,
          'legalities': legalities,
          'games': games_str,
          'reserved': reserved,
          'foil': foil,
          'nonfoil': nonfoil,
          'finishes': finishes_str,
          'oversized': oversized,
          'promo': promo,
          'reprint': reprint,
          'variation': variation,
          'set_id': set_id,
          'set': set,
          'set_name': set_name,
          'set_type': set_type_str,
          'set_uri': set_uri_str,
          'set_search_uri': set_search_uri_str,
          'scryfall_set_uri': scryfall_set_uri_str,
          'rulings_uri': rulings_uri_str,
          'prints_search_uri': prints_search_uri_str,
          'collector_number': collector_number,
          'digital': digital,
          'rarity': rarity_str,
          'flavor_text': flavor_text,
          'card_back_id': card_back_id,
          'artist': artist,
          'artist_ids': artist_ids,
          'illustration_id': illustration_id,
          'border_color': border_color_str,
          'frame': frame_str,
          'security_stamp': security_stamp_str,
          'full_art': full_art,
          'textless': textless,
          'booster': booster,
          'story_spotlight': story_spotlight,
          'edhrec_rank': edhrec_rank,
          'prices': prices,
          'related_uris': related_uris,
          'purchase_uris': purchase_uris,
          'preview': preview,
          'all_parts': all_parts,
          'card_faces': card_faces,
          'produced_mana': produced_mana_str,
          'frame_effects': frame_effects_str,
        };

        final released_at = DateTime.parse(released_at_str);
        final uri = Uri.parse(uri_str);
        final scryfall_uri = Uri.parse(scryfall_uri_str);
        final layout = Layout.normal;
        final image_status = ImageStatus.lowres;
        final colors = [Color.white];
        final color_identity = [Color.white];
        final color_indicator = [Color.white];
        final games = [Game.mtgo];
        final finishes = [Finish.nonfoil, Finish.foil];
        final set_type = SetType.treasureChest;
        final set_uri = Uri.parse(set_uri_str);
        final set_search_uri = Uri.parse(set_search_uri_str);
        final scryfall_set_uri = Uri.parse(scryfall_set_uri_str);
        final rulings_uri = Uri.parse(rulings_uri_str);
        final prints_search_uri = Uri.parse(prints_search_uri_str);
        final rarity = Rarity.rare;
        final border_color = BorderColor.black;
        final frame = Frame.modernHoloFoilStamp_2015;
        final security_stamp = SecurityStamp.oval;
        final produced_mana = [Color.colorless, Color.green];
        final frame_effects = [FrameEffect.legendary];

        expect(
          MtgCard.fromJson(json),
          isA<MtgCard>()
              .having((c) => c.id, 'id', id)
              .having((c) => c.oracleId, 'oracleId', oracle_id)
              .having((c) => c.multiverseIds, 'multiverseIds', multiverse_ids)
              .having((c) => c.mtgoId, 'mtgoId', mtgo_id)
              .having((c) => c.name, 'name', name)
              .having((c) => c.lang, 'lang', lang)
              .having((c) => c.releasedAt, 'releasedAt', released_at)
              .having((c) => c.uri, 'uri', uri)
              .having((c) => c.scryfallUri, 'scryfallUri', scryfall_uri)
              .having((c) => c.layout, 'layout', layout)
              .having((c) => c.highresImage, 'highresImage', highres_image)
              .having((c) => c.imageStatus, 'imageStatus', image_status)
              .having((c) => c.imageUris, 'imageUris', isA<ImageUris>())
              .having((c) => c.manaCost, 'manaCost', mana_cost)
              .having((c) => c.cmc, 'cmc', cmc)
              .having((c) => c.typeLine, 'typeLine', type_line)
              .having((c) => c.oracleText, 'oracleText', oracle_text)
              .having((c) => c.power, 'power', power)
              .having((c) => c.toughness, 'toughness', toughness)
              .having((c) => c.colors, 'colors', colors)
              .having((c) => c.colorIdentity, 'colorIdentity', color_identity)
              .having(
                  (c) => c.colorIndicator, 'colorIndicator', color_indicator)
              .having((c) => c.keywords, 'keywords', keywords)
              .having((c) => c.legalities, 'legalities', isA<Legalities>())
              .having((c) => c.games, 'games', games)
              .having((c) => c.reserved, 'reserved', reserved)
              .having((c) => c.foil, 'foil', foil)
              .having((c) => c.nonfoil, 'nonfoil', nonfoil)
              .having((c) => c.finishes, 'finishes', finishes)
              .having((c) => c.oversized, 'oversized', oversized)
              .having((c) => c.promo, 'promo', promo)
              .having((c) => c.reprint, 'reprint', reprint)
              .having((c) => c.variation, 'variation', variation)
              .having((c) => c.setId, 'setId', set_id)
              .having((c) => c.set, 'set', set)
              .having((c) => c.setName, 'setName', set_name)
              .having((c) => c.setType, 'setType', set_type)
              .having((c) => c.setUri, 'setUri', set_uri)
              .having((c) => c.setSearchUri, 'setSearchUri', set_search_uri)
              .having(
                (c) => c.scryfallSetUri,
                'scryfallSetUri',
                scryfall_set_uri,
              )
              .having((c) => c.rulingsUri, 'rulingsUri', rulings_uri)
              .having(
                (c) => c.printsSearchUri,
                'printsSearchUri',
                prints_search_uri,
              )
              .having(
                (c) => c.collectorNumber,
                'collectorNumber',
                collector_number,
              )
              .having((c) => c.digital, 'digital', digital)
              .having((c) => c.rarity, 'rarity', rarity)
              .having((c) => c.flavorText, 'flavorText', flavor_text)
              .having((c) => c.cardBackId, 'cardBackId', card_back_id)
              .having((c) => c.artist, 'artist', artist)
              .having((c) => c.artistIds, 'artistIds', artist_ids)
              .having(
                (c) => c.illustrationId,
                'illustrationId',
                illustration_id,
              )
              .having((c) => c.borderColor, 'borderColor', border_color)
              .having((c) => c.frame, 'frame', frame)
              .having(
                (c) => c.securityStamp,
                'securityStamp',
                security_stamp,
              )
              .having((c) => c.fullArt, 'fullArt', full_art)
              .having((c) => c.textless, 'textless', textless)
              .having((c) => c.booster, 'booster', booster)
              .having(
                (c) => c.storySpotlight,
                'storySpotlight',
                story_spotlight,
              )
              .having((c) => c.edhrecRank, 'edhrecRank', edhrec_rank)
              .having((c) => c.prices, 'prices', isA<Prices>())
              .having(
                (c) => c.relatedUris,
                'relatedUris',
                isA<Map<String, Uri>>(),
              )
              .having(
                (c) => c.purchaseUris,
                'purchaseUris',
                isA<Map<String, Uri>>(),
              )
              .having((c) => c.preview, 'preview', isA<Preview>())
              .having((c) => c.allParts, 'allParts', isA<List<RelatedCard>>())
              .having((c) => c.cardFaces, 'cardFaces', isA<List<CardFace>>())
              .having((c) => c.producedMana, 'producedMana', produced_mana)
              .having((c) => c.frameEffects, 'frameEffects', frame_effects),
        );
      });
    });
  });
}
