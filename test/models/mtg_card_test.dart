import 'dart:convert';
import 'dart:io';

import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('MtgCard', () {
    final id = '1ebf9dea-b4f8-4955-9824-7da5bbba91e9';
    final oracleId = '7d6c4290-d46d-4b98-805c-3f537462c4c8';
    final multiverseIds = [];
    final mtgoId = 65801;
    final name = 'Huang Zhong, Shu General';
    final langStr = 'en';
    final releasedAtStr = '2016-11-16';
    final uriStr =
        'https://api.scryfall.com/cards/1ebf9dea-b4f8-4955-9824-7da5bbba91e9';
    final scryfallUriStr =
        'https://scryfall.com/card/pz2/65801/huang-zhong-shu-general?utm_source=api';
    final layoutStr = 'normal';
    final highresImage = false;
    final imageStatusStr = 'lowres';
    final imageUris = {
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
    final manaCost = '{2}{W}{W}';
    final cmc = 4;
    final typeLine = 'Legendary Creature — Human Soldier';
    final oracleText =
        'Huang Zhong, Shu General can\'t be blocked by more than one creature.';
    final power = '2';
    final toughness = '3';
    final colorsStr = ['W'];
    final colorIdentityStr = ['W'];
    final colorIndicatorStr = ['W'];
    final keywords = [];
    final legalities = {
      'standard': 'not_legal',
      'future': 'not_legal',
      'historic': 'not_legal',
      'timeless': 'not_legal',
      'gladiator': 'not_legal',
      'pioneer': 'not_legal',
      'explorer': 'not_legal',
      'modern': 'not_legal',
      'legacy': 'legal',
      'pauper': 'not_legal',
      'vintage': 'legal',
      'penny': 'not_legal',
      'commander': 'legal',
      'oathbreaker': 'legal',
      'standardbrawl': 'not_legal',
      'brawl': 'not_legal',
      'alchemy': 'not_legal',
      'paupercommander': 'not_legal',
      'duel': 'legal',
      'oldschool': 'not_legal',
      'premodern': 'not_legal',
      'predh': 'legal'
    };
    final gamesStr = ['mtgo'];
    final reserved = false;
    final foil = true;
    final nonfoil = true;
    final finishesStr = ['nonfoil', 'foil'];
    final oversized = false;
    final promo = false;
    final reprint = true;
    final variation = false;
    final setId = '2661b143-8eac-4c73-9d93-549fe928bd96';
    final set = 'pz2';
    final setName = 'Treasure Chest';
    final setTypeStr = 'treasure_chest';
    final setUriStr =
        'https://api.scryfall.com/sets/2661b143-8eac-4c73-9d93-549fe928bd96';
    final setSearchUriStr =
        'https://api.scryfall.com/cards/search?order=set&q=e%3Apz2&unique=prints';
    final scryfallSetUriStr = 'https://scryfall.com/sets/pz2?utm_source=api';
    final rulingsUriStr =
        'https://api.scryfall.com/cards/1ebf9dea-b4f8-4955-9824-7da5bbba91e9/rulings';
    final printsSearchUriStr =
        'https://api.scryfall.com/cards/search?order=released&q=oracleid%3A7d6c4290-d46d-4b98-805c-3f537462c4c8&unique=prints';
    final collectorNumber = '65801';
    final digital = true;
    final rarityStr = 'rare';
    final flavorText =
        '\'Virile in war, he kept the north in fear; His prodigies subdued the western sphere.\'';
    final cardBackId = '0aeebaf5-8c7d-4636-9e82-8c27447861f7';
    final artist = 'Quan Xuejun';
    final artistIds = ['0dee7feb-9e78-4d1b-9458-52c8cb7ad078'];
    final illustrationId = '8e729a46-ab8b-411c-9cef-8f4a7b67beca';
    final borderColorStr = 'black';
    final frameStr = '2015';
    final securityStampStr = 'oval';
    final fullArt = false;
    final textless = false;
    final booster = false;
    final storySpotlight = false;
    final edhrecRank = 21021;
    final prices = {
      'usd': null,
      'usd_foil': null,
      'usd_etched': null,
      'eur': null,
      'eur_foil': null,
      'tix': '1.10'
    };
    final relatedUris = {
      'tcgplayer_infinite_articles':
          'https://infinite.tcgplayer.com/search?contentMode=article&game=magic&partner=scryfall&q=Huang+Zhong%2C+Shu+General&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
      'tcgplayer_infinite_decks':
          'https://infinite.tcgplayer.com/search?contentMode=deck&game=magic&partner=scryfall&q=Huang+Zhong%2C+Shu+General&utm_campaign=affiliate&utm_medium=api&utm_source=scryfall',
      'edhrec': 'https://edhrec.com/route/?cc=Huang+Zhong%2C+Shu+General',
      'mtgtop8':
          'https://mtgtop8.com/search?MD_check=1&SB_check=1&cards=Huang+Zhong%2C+Shu+General'
    };
    final purchaseUris = {
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
    final allParts = [
      {
        'object': 'related_card',
        'id': '1ce91e38-4601-4354-ad1b-2c5c1c70da17',
        'component': 'combo_piece',
        'name': 'Ruthless Knave',
        'type_line': 'Creature — Orc Pirate',
        'uri':
            'https://api.scryfall.com/cards/1ce91e38-4601-4354-ad1b-2c5c1c70da17'
      },
      {
        'object': 'related_card',
        'id': '720f3e68-84c0-462e-a0d1-90236ccc494a',
        'component': 'token',
        'name': 'Treasure',
        'type_line': 'Token Artifact — Treasure',
        'uri':
            'https://api.scryfall.com/cards/720f3e68-84c0-462e-a0d1-90236ccc494a'
      },
    ];
    final cardFaces = [
      {
        'object': 'card_face',
        'name': 'Professor of Zoomancy',
        'mana_cost': '',
        'type_line': 'Card',
        'oracle_text': '',
        'colors': [],
        'artist': 'Rudy Siswanto',
        'artist_id': '23f86db1-9103-49bb-83d5-0fda18143921',
        'illustration_id': '45d02cb9-5ce4-43ef-9a02-5f1e470e153d',
        'cmc': 0,
        'color_indicator': [],
        'defense': '2',
        'image_uris': {
          'small':
              'https://c1.scryfall.com/file/scryfall-cards/small/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'normal':
              'https://c1.scryfall.com/file/scryfall-cards/normal/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'large':
              'https://c1.scryfall.com/file/scryfall-cards/large/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'png':
              'https://c1.scryfall.com/file/scryfall-cards/png/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.png?1619463614',
          'art_crop':
              'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'border_crop':
              'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614'
        }
      },
      {
        'object': 'card_face',
        'name': 'Professor of Zoomancy',
        'flavor_name': '',
        'mana_cost': '',
        'type_line': 'Card',
        'oracle_text': '',
        'colors': [],
        'artist': 'Rudy Siswanto',
        'artist_id': '23f86db1-9103-49bb-83d5-0fda18143921',
        'illustration_id': '9f59e837-24dd-47ad-83d0-f3ec4b290963',
        'cmc': 4.0,
        'color_indicator': ['W'],
        'layout': 'normal',
        'oracle_id': '7d6c4290-d46d-4b98-805c-3f537462c4c8',
        'image_uris': {
          'small':
              'https://c1.scryfall.com/file/scryfall-cards/small/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'normal':
              'https://c1.scryfall.com/file/scryfall-cards/normal/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'large':
              'https://c1.scryfall.com/file/scryfall-cards/large/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'png':
              'https://c1.scryfall.com/file/scryfall-cards/png/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.png?1619463614',
          'art_crop':
              'https://c1.scryfall.com/file/scryfall-cards/art_crop/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614',
          'border_crop':
              'https://c1.scryfall.com/file/scryfall-cards/border_crop/back/3/6/364535a0-fa83-4e27-8cce-b38481b5eff1.jpg?1619463614'
        },
      }
    ];
    final producedManaStr = ['C', 'G'];
    final frameEffectsStr = ['legendary'];
    final tgcPlayerEtchedId = 1;
    final attractionLights = [1, 2];

    final json = <String, dynamic>{
      'object': 'card',
      'id': id,
      'oracle_id': oracleId,
      'multiverse_ids': multiverseIds,
      'mtgo_id': mtgoId,
      'name': name,
      'lang': langStr,
      'released_at': releasedAtStr,
      'uri': uriStr,
      'scryfall_uri': scryfallUriStr,
      'layout': layoutStr,
      'highres_image': highresImage,
      'image_status': imageStatusStr,
      'image_uris': imageUris,
      'mana_cost': manaCost,
      'cmc': cmc,
      'type_line': typeLine,
      'oracle_text': oracleText,
      'power': power,
      'toughness': toughness,
      'colors': colorsStr,
      'color_identity': colorIdentityStr,
      'color_indicator': colorIndicatorStr,
      'keywords': keywords,
      'legalities': legalities,
      'games': gamesStr,
      'reserved': reserved,
      'foil': foil,
      'nonfoil': nonfoil,
      'finishes': finishesStr,
      'oversized': oversized,
      'promo': promo,
      'reprint': reprint,
      'variation': variation,
      'set_id': setId,
      'set': set,
      'set_name': setName,
      'set_type': setTypeStr,
      'set_uri': setUriStr,
      'set_search_uri': setSearchUriStr,
      'scryfall_set_uri': scryfallSetUriStr,
      'rulings_uri': rulingsUriStr,
      'prints_search_uri': printsSearchUriStr,
      'collector_number': collectorNumber,
      'digital': digital,
      'rarity': rarityStr,
      'flavor_text': flavorText,
      'card_back_id': cardBackId,
      'artist': artist,
      'artist_ids': artistIds,
      'illustration_id': illustrationId,
      'border_color': borderColorStr,
      'frame': frameStr,
      'security_stamp': securityStampStr,
      'full_art': fullArt,
      'textless': textless,
      'booster': booster,
      'story_spotlight': storySpotlight,
      'edhrec_rank': edhrecRank,
      'prices': prices,
      'related_uris': relatedUris,
      'purchase_uris': purchaseUris,
      'preview': preview,
      'all_parts': allParts,
      'card_faces': cardFaces,
      'produced_mana': producedManaStr,
      'frame_effects': frameEffectsStr,
      'flavor_name': name,
      'printed_name': name,
      'printed_text': oracleText,
      'printed_type_line': typeLine,
      'tcgplayer_etched_id': tgcPlayerEtchedId,
      'attraction_lights': attractionLights,
    };

    group('fromJson', () {
      test('returns correct MtgCard for single-faced card', () {
        final lang = Language.english;
        final releasedAt = DateTime.parse(releasedAtStr);
        final uri = Uri.parse(uriStr);
        final scryfallUri = Uri.parse(scryfallUriStr);
        final layout = Layout.normal;
        final imageStatus = ImageStatus.lowres;
        final colors = [Color.white];
        final colorIdentity = [Color.white];
        final colorIndicator = [Color.white];
        final games = [Game.mtgo];
        final finishes = [Finish.nonfoil, Finish.foil];
        final setType = SetType.treasureChest;
        final setUri = Uri.parse(setUriStr);
        final setSearchUri = Uri.parse(setSearchUriStr);
        final scryfallSetUri = Uri.parse(scryfallSetUriStr);
        final rulingsUri = Uri.parse(rulingsUriStr);
        final printsSearchUri = Uri.parse(printsSearchUriStr);
        final rarity = Rarity.rare;
        final borderColor = BorderColor.black;
        final frame = Frame.modernHoloFoilStamp_2015;
        final securityStamp = SecurityStamp.oval;
        final producedMana = [Color.colorless, Color.green];
        final frameEffects = [FrameEffect.legendary];

        expect(
          MtgCard.fromJson(json),
          isA<MtgCard>()
              .having((c) => c.id, 'id', id)
              .having((c) => c.oracleId, 'oracleId', oracleId)
              .having((c) => c.multiverseIds, 'multiverseIds', multiverseIds)
              .having((c) => c.mtgoId, 'mtgoId', mtgoId)
              .having((c) => c.name, 'name', name)
              .having((c) => c.lang, 'lang', lang)
              .having((c) => c.releasedAt, 'releasedAt', releasedAt)
              .having((c) => c.uri, 'uri', uri)
              .having((c) => c.scryfallUri, 'scryfallUri', scryfallUri)
              .having((c) => c.layout, 'layout', layout)
              .having((c) => c.highresImage, 'highresImage', highresImage)
              .having((c) => c.imageStatus, 'imageStatus', imageStatus)
              .having((c) => c.imageUris, 'imageUris', isA<ImageUris>())
              .having((c) => c.manaCost, 'manaCost', manaCost)
              .having((c) => c.cmc, 'cmc', cmc)
              .having((c) => c.typeLine, 'typeLine', typeLine)
              .having((c) => c.oracleText, 'oracleText', oracleText)
              .having((c) => c.power, 'power', power)
              .having((c) => c.toughness, 'toughness', toughness)
              .having((c) => c.colors, 'colors', colors)
              .having((c) => c.colorIdentity, 'colorIdentity', colorIdentity)
              .having((c) => c.colorIndicator, 'colorIndicator', colorIndicator)
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
              .having((c) => c.setId, 'setId', setId)
              .having((c) => c.set, 'set', set)
              .having((c) => c.setName, 'setName', setName)
              .having((c) => c.setType, 'setType', setType)
              .having((c) => c.setUri, 'setUri', setUri)
              .having((c) => c.setSearchUri, 'setSearchUri', setSearchUri)
              .having(
                (c) => c.scryfallSetUri,
                'scryfallSetUri',
                scryfallSetUri,
              )
              .having((c) => c.rulingsUri, 'rulingsUri', rulingsUri)
              .having(
                (c) => c.printsSearchUri,
                'printsSearchUri',
                printsSearchUri,
              )
              .having(
                (c) => c.collectorNumber,
                'collectorNumber',
                collectorNumber,
              )
              .having((c) => c.digital, 'digital', digital)
              .having((c) => c.rarity, 'rarity', rarity)
              .having((c) => c.flavorText, 'flavorText', flavorText)
              .having((c) => c.cardBackId, 'cardBackId', cardBackId)
              .having((c) => c.artist, 'artist', artist)
              .having((c) => c.artistIds, 'artistIds', artistIds)
              .having(
                (c) => c.illustrationId,
                'illustrationId',
                illustrationId,
              )
              .having((c) => c.borderColor, 'borderColor', borderColor)
              .having((c) => c.frame, 'frame', frame)
              .having(
                (c) => c.securityStamp,
                'securityStamp',
                securityStamp,
              )
              .having((c) => c.fullArt, 'fullArt', fullArt)
              .having((c) => c.textless, 'textless', textless)
              .having((c) => c.booster, 'booster', booster)
              .having(
                (c) => c.storySpotlight,
                'storySpotlight',
                storySpotlight,
              )
              .having((c) => c.edhrecRank, 'edhrecRank', edhrecRank)
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
              .having((c) => c.producedMana, 'producedMana', producedMana)
              .having((c) => c.frameEffects, 'frameEffects', frameEffects)
              .having(
                (c) => c.tcgplayerEtchedId,
                'tgcplayerEtchedId',
                tgcPlayerEtchedId,
              )
              .having(
                (c) => c.attractionLights,
                'attractionLights',
                attractionLights,
              ),
        );
      });
    });

    group('toJson', () {
      test('returns correct JSON for single-faced card', () {
        expect(
          MtgCard.fromJson(json).toJson(),
          json,
        );
      });
    });
  });

  group('MtgCard without oracleId', () {
    test('can be parsed', () async {
      final file = File('test/mock_data/mtg_card_ecl_348.json');
      final json =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;

      final card = MtgCard.fromJson(json);

      expect(card.oracleId, '17039058-822d-409f-938c-b727a366ba63');
      expect(card.cmc, 0);
      expect(card.typeLine, 'Land — Island Mountain');
    });
  });
}
