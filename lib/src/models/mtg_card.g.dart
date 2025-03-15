// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtg_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MtgCard _$MtgCardFromJson(Map<String, dynamic> json) => $checkedCreate(
      'MtgCard',
      json,
      ($checkedConvert) {
        final val = MtgCard(
          arenaId: $checkedConvert('arena_id', (v) => (v as num?)?.toInt()),
          id: $checkedConvert('id', (v) => v as String),
          lang: $checkedConvert(
              'lang',
              (v) => $enumDecode(_$LanguageEnumMap, v,
                  unknownValue: Language.unknown)),
          mtgoId: $checkedConvert('mtgo_id', (v) => (v as num?)?.toInt()),
          mtgoFoilId:
              $checkedConvert('mtgo_foil_id', (v) => (v as num?)?.toInt()),
          multiverseIds: $checkedConvert(
              'multiverse_ids',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList()),
          tcgplayerId:
              $checkedConvert('tcgplayer_id', (v) => (v as num?)?.toInt()),
          tcgplyerEtchedId: $checkedConvert(
              'tcgplyer_etched_id', (v) => (v as num?)?.toInt()),
          cardmarketId:
              $checkedConvert('cardmarket_id', (v) => (v as num?)?.toInt()),
          oracleId: $checkedConvert('oracle_id', (v) => v as String),
          printsSearchUri: $checkedConvert(
              'prints_search_uri', (v) => Uri.parse(v as String)),
          rulingsUri:
              $checkedConvert('rulings_uri', (v) => Uri.parse(v as String)),
          scryfallUri:
              $checkedConvert('scryfall_uri', (v) => Uri.parse(v as String)),
          uri: $checkedConvert('uri', (v) => Uri.parse(v as String)),
          allParts: $checkedConvert(
              'all_parts',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => RelatedCard.fromJson(e as Map<String, dynamic>))
                  .toList()),
          cardFaces: $checkedConvert(
              'card_faces',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => CardFace.fromJson(e as Map<String, dynamic>))
                  .toList()),
          cmc: $checkedConvert('cmc', (v) => (v as num).toDouble()),
          colorIdentity: $checkedConvert(
              'color_identity',
              (v) => (v as List<dynamic>)
                  .map((e) => $enumDecode(_$ColorEnumMap, e,
                      unknownValue: Color.unknown))
                  .toList()),
          colorIndicator: $checkedConvert(
              'color_indicator',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$ColorEnumMap, e,
                      unknownValue: Color.unknown))
                  .toList()),
          colors: $checkedConvert(
              'colors',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$ColorEnumMap, e,
                      unknownValue: Color.unknown))
                  .toList()),
          edhrecRank:
              $checkedConvert('edhrec_rank', (v) => (v as num?)?.toInt()),
          handModifier: $checkedConvert('hand_modifier', (v) => v as String?),
          keywords: $checkedConvert('keywords',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          layout: $checkedConvert(
              'layout',
              (v) => $enumDecode(_$LayoutEnumMap, v,
                  unknownValue: Layout.unknown)),
          legalities: $checkedConvert('legalities',
              (v) => Legalities.fromJson(v as Map<String, dynamic>)),
          lifeModifier: $checkedConvert('life_modifier', (v) => v as String?),
          loyalty: $checkedConvert('loyalty', (v) => v as String?),
          manaCost: $checkedConvert('mana_cost', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String),
          oracleText: $checkedConvert('oracle_text', (v) => v as String?),
          oversized: $checkedConvert('oversized', (v) => v as bool),
          power: $checkedConvert('power', (v) => v as String?),
          producedMana: $checkedConvert(
              'produced_mana',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$ColorEnumMap, e,
                      unknownValue: Color.unknown))
                  .toList()),
          reserved: $checkedConvert('reserved', (v) => v as bool),
          toughness: $checkedConvert('toughness', (v) => v as String?),
          typeLine: $checkedConvert('type_line', (v) => v as String),
          artist: $checkedConvert('artist', (v) => v as String?),
          artistIds: $checkedConvert('artist_ids',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          attractionLights: $checkedConvert(
              'attraction_lights',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList()),
          booster: $checkedConvert('booster', (v) => v as bool),
          borderColor: $checkedConvert(
              'border_color',
              (v) => $enumDecode(_$BorderColorEnumMap, v,
                  unknownValue: BorderColor.unknown)),
          cardBackId: $checkedConvert('card_back_id', (v) => v as String?),
          collectorNumber:
              $checkedConvert('collector_number', (v) => v as String),
          contentWarning: $checkedConvert('content_warning', (v) => v as bool?),
          digital: $checkedConvert('digital', (v) => v as bool),
          foil: $checkedConvert('foil', (v) => v as bool),
          nonfoil: $checkedConvert('nonfoil', (v) => v as bool),
          finishes: $checkedConvert(
              'finishes',
              (v) => (v as List<dynamic>)
                  .map((e) => $enumDecode(_$FinishEnumMap, e,
                      unknownValue: Finish.unknown))
                  .toList()),
          flavorName: $checkedConvert('flavor_name', (v) => v as String?),
          flavorText: $checkedConvert('flavor_text', (v) => v as String?),
          frameEffects: $checkedConvert(
              'frame_effects',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$FrameEffectEnumMap, e,
                      unknownValue: FrameEffect.unknown))
                  .toList()),
          frame: $checkedConvert(
              'frame',
              (v) =>
                  $enumDecode(_$FrameEnumMap, v, unknownValue: Frame.unknown)),
          fullArt: $checkedConvert('full_art', (v) => v as bool),
          games: $checkedConvert(
              'games',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      $enumDecode(_$GameEnumMap, e, unknownValue: Game.unknown))
                  .toList()),
          highresImage: $checkedConvert('highres_image', (v) => v as bool),
          illustrationId:
              $checkedConvert('illustration_id', (v) => v as String?),
          imageStatus: $checkedConvert(
              'image_status',
              (v) => $enumDecode(_$ImageStatusEnumMap, v,
                  unknownValue: ImageStatus.unknown)),
          imageUris: $checkedConvert(
              'image_uris',
              (v) => v == null
                  ? null
                  : ImageUris.fromJson(v as Map<String, dynamic>)),
          prices: $checkedConvert(
              'prices', (v) => Prices.fromJson(v as Map<String, dynamic>)),
          printedName: $checkedConvert('printed_name', (v) => v as String?),
          printedText: $checkedConvert('printed_text', (v) => v as String?),
          printedTypeLine:
              $checkedConvert('printed_type_line', (v) => v as String?),
          promo: $checkedConvert('promo', (v) => v as bool),
          promoType: $checkedConvert('promo_type',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          purchaseUris: $checkedConvert(
              'purchase_uris',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, Uri.parse(e as String)),
                  )),
          rarity: $checkedConvert(
              'rarity',
              (v) => $enumDecode(_$RarityEnumMap, v,
                  unknownValue: Rarity.unknown)),
          relatedUris: $checkedConvert(
              'related_uris',
              (v) => (v as Map<String, dynamic>).map(
                    (k, e) => MapEntry(k, Uri.parse(e as String)),
                  )),
          releasedAt: $checkedConvert(
              'released_at', (v) => DateTime.parse(v as String)),
          reprint: $checkedConvert('reprint', (v) => v as bool),
          scryfallSetUri: $checkedConvert(
              'scryfall_set_uri', (v) => Uri.parse(v as String)),
          setName: $checkedConvert('set_name', (v) => v as String),
          setSearchUri:
              $checkedConvert('set_search_uri', (v) => Uri.parse(v as String)),
          setType: $checkedConvert(
              'set_type',
              (v) => $enumDecode(_$SetTypeEnumMap, v,
                  unknownValue: SetType.unknown)),
          setUri: $checkedConvert('set_uri', (v) => Uri.parse(v as String)),
          set: $checkedConvert('set', (v) => v as String),
          setId: $checkedConvert('set_id', (v) => v as String),
          storySpotlight: $checkedConvert('story_spotlight', (v) => v as bool),
          textless: $checkedConvert('textless', (v) => v as bool),
          variation: $checkedConvert('variation', (v) => v as bool),
          variationOf: $checkedConvert('variation_of', (v) => v as String?),
          securityStamp: $checkedConvert(
              'security_stamp',
              (v) => $enumDecodeNullable(_$SecurityStampEnumMap, v,
                  unknownValue: SecurityStamp.unknown)),
          watermark: $checkedConvert('watermark', (v) => v as String?),
          preview: $checkedConvert(
              'preview',
              (v) => v == null
                  ? null
                  : Preview.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'arenaId': 'arena_id',
        'mtgoId': 'mtgo_id',
        'mtgoFoilId': 'mtgo_foil_id',
        'multiverseIds': 'multiverse_ids',
        'tcgplayerId': 'tcgplayer_id',
        'tcgplyerEtchedId': 'tcgplyer_etched_id',
        'cardmarketId': 'cardmarket_id',
        'oracleId': 'oracle_id',
        'printsSearchUri': 'prints_search_uri',
        'rulingsUri': 'rulings_uri',
        'scryfallUri': 'scryfall_uri',
        'allParts': 'all_parts',
        'cardFaces': 'card_faces',
        'colorIdentity': 'color_identity',
        'colorIndicator': 'color_indicator',
        'edhrecRank': 'edhrec_rank',
        'handModifier': 'hand_modifier',
        'lifeModifier': 'life_modifier',
        'manaCost': 'mana_cost',
        'oracleText': 'oracle_text',
        'producedMana': 'produced_mana',
        'typeLine': 'type_line',
        'artistIds': 'artist_ids',
        'attractionLights': 'attraction_lights',
        'borderColor': 'border_color',
        'cardBackId': 'card_back_id',
        'collectorNumber': 'collector_number',
        'contentWarning': 'content_warning',
        'flavorName': 'flavor_name',
        'flavorText': 'flavor_text',
        'frameEffects': 'frame_effects',
        'fullArt': 'full_art',
        'highresImage': 'highres_image',
        'illustrationId': 'illustration_id',
        'imageStatus': 'image_status',
        'imageUris': 'image_uris',
        'printedName': 'printed_name',
        'printedText': 'printed_text',
        'printedTypeLine': 'printed_type_line',
        'promoType': 'promo_type',
        'purchaseUris': 'purchase_uris',
        'relatedUris': 'related_uris',
        'releasedAt': 'released_at',
        'scryfallSetUri': 'scryfall_set_uri',
        'setName': 'set_name',
        'setSearchUri': 'set_search_uri',
        'setType': 'set_type',
        'setUri': 'set_uri',
        'setId': 'set_id',
        'storySpotlight': 'story_spotlight',
        'variationOf': 'variation_of',
        'securityStamp': 'security_stamp'
      },
    );

Map<String, dynamic> _$MtgCardToJson(MtgCard instance) => <String, dynamic>{
      'arena_id': instance.arenaId,
      'id': instance.id,
      'lang': _$LanguageEnumMap[instance.lang]!,
      'mtgo_id': instance.mtgoId,
      'mtgo_foil_id': instance.mtgoFoilId,
      'multiverse_ids': instance.multiverseIds,
      'tcgplayer_id': instance.tcgplayerId,
      'tcgplyer_etched_id': instance.tcgplyerEtchedId,
      'cardmarket_id': instance.cardmarketId,
      'oracle_id': instance.oracleId,
      'prints_search_uri': instance.printsSearchUri.toString(),
      'rulings_uri': instance.rulingsUri.toString(),
      'scryfall_uri': instance.scryfallUri.toString(),
      'uri': instance.uri.toString(),
      'all_parts': instance.allParts?.map((e) => e.toJson()).toList(),
      'card_faces': instance.cardFaces?.map((e) => e.toJson()).toList(),
      'cmc': instance.cmc,
      'color_identity':
          instance.colorIdentity.map((e) => _$ColorEnumMap[e]!).toList(),
      'color_indicator':
          instance.colorIndicator?.map((e) => _$ColorEnumMap[e]!).toList(),
      'colors': instance.colors?.map((e) => _$ColorEnumMap[e]!).toList(),
      'edhrec_rank': instance.edhrecRank,
      'hand_modifier': instance.handModifier,
      'keywords': instance.keywords,
      'layout': _$LayoutEnumMap[instance.layout]!,
      'legalities': instance.legalities.toJson(),
      'life_modifier': instance.lifeModifier,
      'loyalty': instance.loyalty,
      'mana_cost': instance.manaCost,
      'name': instance.name,
      'oracle_text': instance.oracleText,
      'oversized': instance.oversized,
      'power': instance.power,
      'produced_mana':
          instance.producedMana?.map((e) => _$ColorEnumMap[e]!).toList(),
      'reserved': instance.reserved,
      'toughness': instance.toughness,
      'type_line': instance.typeLine,
      'artist': instance.artist,
      'artist_ids': instance.artistIds,
      'attraction_lights': instance.attractionLights,
      'booster': instance.booster,
      'border_color': _$BorderColorEnumMap[instance.borderColor]!,
      'card_back_id': instance.cardBackId,
      'collector_number': instance.collectorNumber,
      'content_warning': instance.contentWarning,
      'digital': instance.digital,
      'foil': instance.foil,
      'nonfoil': instance.nonfoil,
      'finishes': instance.finishes.map((e) => _$FinishEnumMap[e]!).toList(),
      'flavor_name': instance.flavorName,
      'flavor_text': instance.flavorText,
      'frame_effects':
          instance.frameEffects?.map((e) => _$FrameEffectEnumMap[e]!).toList(),
      'frame': _$FrameEnumMap[instance.frame]!,
      'full_art': instance.fullArt,
      'games': instance.games.map((e) => _$GameEnumMap[e]!).toList(),
      'highres_image': instance.highresImage,
      'illustration_id': instance.illustrationId,
      'image_status': _$ImageStatusEnumMap[instance.imageStatus]!,
      'image_uris': instance.imageUris?.toJson(),
      'prices': instance.prices.toJson(),
      'printed_name': instance.printedName,
      'printed_text': instance.printedText,
      'printed_type_line': instance.printedTypeLine,
      'promo': instance.promo,
      'promo_type': instance.promoType,
      'purchase_uris':
          instance.purchaseUris?.map((k, e) => MapEntry(k, e.toString())),
      'rarity': _$RarityEnumMap[instance.rarity]!,
      'related_uris':
          instance.relatedUris.map((k, e) => MapEntry(k, e.toString())),
      'released_at': instance.releasedAt.toIso8601String(),
      'reprint': instance.reprint,
      'scryfall_set_uri': instance.scryfallSetUri.toString(),
      'set_name': instance.setName,
      'set_search_uri': instance.setSearchUri.toString(),
      'set_type': _$SetTypeEnumMap[instance.setType]!,
      'set_uri': instance.setUri.toString(),
      'set': instance.set,
      'set_id': instance.setId,
      'story_spotlight': instance.storySpotlight,
      'textless': instance.textless,
      'variation': instance.variation,
      'variation_of': instance.variationOf,
      'security_stamp': _$SecurityStampEnumMap[instance.securityStamp],
      'watermark': instance.watermark,
      'preview': instance.preview?.toJson(),
      'object': instance.object,
    };

const _$LanguageEnumMap = {
  Language.english: 'en',
  Language.spanish: 'es',
  Language.french: 'fr',
  Language.german: 'de',
  Language.italian: 'it',
  Language.portuguese: 'pt',
  Language.japanese: 'ja',
  Language.korean: 'ko',
  Language.russian: 'ru',
  Language.chineseSimplified: 'zhs',
  Language.chineseTraditional: 'zht',
  Language.hebrew: 'he',
  Language.latin: 'la',
  Language.ancientGreek: 'grc',
  Language.arabic: 'ar',
  Language.sanskrit: 'sa',
  Language.phyrexian: 'ph',
  Language.unknown: 'unknown',
};

const _$ColorEnumMap = {
  Color.white: 'W',
  Color.blue: 'U',
  Color.black: 'B',
  Color.red: 'R',
  Color.green: 'G',
  Color.colorless: 'C',
  Color.unknown: 'unknown',
};

const _$LayoutEnumMap = {
  Layout.normal: 'normal',
  Layout.split: 'split',
  Layout.flip: 'flip',
  Layout.transform: 'transform',
  Layout.modalDfc: 'modal_dfc',
  Layout.meld: 'meld',
  Layout.leveler: 'leveler',
  Layout.clazz: 'class',
  Layout.caze: 'case',
  Layout.saga: 'saga',
  Layout.adventure: 'adventure',
  Layout.mutate: 'mutate',
  Layout.prototype: 'prototype',
  Layout.battle: 'battle',
  Layout.planar: 'planar',
  Layout.scheme: 'scheme',
  Layout.vanguard: 'vanguard',
  Layout.token: 'token',
  Layout.doubleFacedToken: 'double_faced_token',
  Layout.emblem: 'emblem',
  Layout.augment: 'augment',
  Layout.host: 'host',
  Layout.artSeries: 'art_series',
  Layout.reversibleCard: 'reversible_card',
  Layout.unknown: 'unknown',
};

const _$BorderColorEnumMap = {
  BorderColor.black: 'black',
  BorderColor.white: 'white',
  BorderColor.borderless: 'borderless',
  BorderColor.silver: 'silver',
  BorderColor.gold: 'gold',
  BorderColor.unknown: 'unknown',
};

const _$FinishEnumMap = {
  Finish.foil: 'foil',
  Finish.nonfoil: 'nonfoil',
  Finish.etched: 'etched',
  Finish.glossy: 'glossy',
  Finish.unknown: 'unknown',
};

const _$FrameEffectEnumMap = {
  FrameEffect.legendary: 'legendary',
  FrameEffect.miracle: 'miracle',
  FrameEffect.nyxtouched: 'nyxtouched',
  FrameEffect.draft: 'draft',
  FrameEffect.devoid: 'devoid',
  FrameEffect.tombstone: 'tombstone',
  FrameEffect.colorshifted: 'colorshifted',
  FrameEffect.inverted: 'inverted',
  FrameEffect.sunmoondfc: 'sunmoondfc',
  FrameEffect.compasslanddfc: 'compasslanddfc',
  FrameEffect.originpwdfc: 'originpwdfc',
  FrameEffect.mooneldrazidfc: 'mooneldrazidfc',
  FrameEffect.waxingandwaningmoondfc: 'waxingandwaningmoondfc',
  FrameEffect.showcase: 'showcase',
  FrameEffect.extendedart: 'extendedart',
  FrameEffect.companion: 'companion',
  FrameEffect.etched: 'etched',
  FrameEffect.snow: 'snow',
  FrameEffect.lesson: 'lesson',
  FrameEffect.shatteredglass: 'shatteredglass',
  FrameEffect.convertdfc: 'convertdfc',
  FrameEffect.fandfc: 'fandfc',
  FrameEffect.upsidedowndfc: 'upsidedowndfc',
  FrameEffect.spree: 'spree',
  FrameEffect.unknown: 'unknown',
};

const _$FrameEnumMap = {
  Frame.classic_1993: '1993',
  Frame.classicUpdated_1997: '1997',
  Frame.modern_2003: '2003',
  Frame.modernHoloFoilStamp_2015: '2015',
  Frame.future: 'future',
  Frame.unknown: 'unknown',
};

const _$GameEnumMap = {
  Game.paper: 'paper',
  Game.arena: 'arena',
  Game.mtgo: 'mtgo',
  Game.unknown: 'unknown',
};

const _$ImageStatusEnumMap = {
  ImageStatus.missing: 'missing',
  ImageStatus.placeholder: 'placeholder',
  ImageStatus.lowres: 'lowres',
  ImageStatus.highresScan: 'highres_scan',
  ImageStatus.unknown: 'unknown',
};

const _$RarityEnumMap = {
  Rarity.common: 'common',
  Rarity.uncommon: 'uncommon',
  Rarity.rare: 'rare',
  Rarity.special: 'special',
  Rarity.mythic: 'mythic',
  Rarity.bonus: 'bonus',
  Rarity.unknown: 'unknown',
};

const _$SetTypeEnumMap = {
  SetType.core: 'core',
  SetType.expansion: 'expansion',
  SetType.masters: 'masters',
  SetType.masterpiece: 'masterpiece',
  SetType.arsenal: 'arsenal',
  SetType.fromTheVault: 'from_the_vault',
  SetType.spellbook: 'spellbook',
  SetType.premiumDeck: 'premium_deck',
  SetType.duelDeck: 'duel_deck',
  SetType.draftInnovation: 'draft_innovation',
  SetType.treasureChest: 'treasure_chest',
  SetType.commander: 'commander',
  SetType.planechase: 'planechase',
  SetType.archenemy: 'archenemy',
  SetType.vanguard: 'vanguard',
  SetType.funny: 'funny',
  SetType.starter: 'starter',
  SetType.box: 'box',
  SetType.promo: 'promo',
  SetType.token: 'token',
  SetType.memorabilia: 'memorabilia',
  SetType.unknown: 'unknown',
};

const _$SecurityStampEnumMap = {
  SecurityStamp.oval: 'oval',
  SecurityStamp.triangle: 'triangle',
  SecurityStamp.acorn: 'acorn',
  SecurityStamp.circle: 'circle',
  SecurityStamp.arena: 'arena',
  SecurityStamp.heart: 'heart',
  SecurityStamp.unknown: 'unknown',
};
