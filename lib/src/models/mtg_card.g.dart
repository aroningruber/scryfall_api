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
          tcgplayerEtchedId: $checkedConvert(
              'tcgplayer_etched_id', (v) => (v as num?)?.toInt()),
          cardmarketId:
              $checkedConvert('cardmarket_id', (v) => (v as num?)?.toInt()),
          oracleId: $checkedConvert(
            'oracle_id',
            (v) => v as String,
            readValue: _readValueFromCardFaceIfReversibleCard,
          ),
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
          cmc: $checkedConvert(
            'cmc',
            (v) => (v as num).toDouble(),
            readValue: _readValueFromCardFaceIfReversibleCard,
          ),
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
          gameChanger: $checkedConvert('game_changer', (v) => v as bool?),
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
          pennyRank: $checkedConvert('penny_rank', (v) => (v as num?)?.toInt()),
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
          typeLine: $checkedConvert(
            'type_line',
            (v) => v as String,
            readValue: _readValueFromCardFaceIfReversibleCard,
          ),
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
          promoTypes: $checkedConvert('promo_types',
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
        'tcgplayerEtchedId': 'tcgplayer_etched_id',
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
        'gameChanger': 'game_changer',
        'handModifier': 'hand_modifier',
        'lifeModifier': 'life_modifier',
        'manaCost': 'mana_cost',
        'oracleText': 'oracle_text',
        'pennyRank': 'penny_rank',
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
        'promoTypes': 'promo_types',
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
      if (instance.arenaId case final value?) 'arena_id': value,
      'id': instance.id,
      'lang': _$LanguageEnumMap[instance.lang]!,
      if (instance.mtgoId case final value?) 'mtgo_id': value,
      if (instance.mtgoFoilId case final value?) 'mtgo_foil_id': value,
      if (instance.multiverseIds case final value?) 'multiverse_ids': value,
      if (instance.tcgplayerId case final value?) 'tcgplayer_id': value,
      if (instance.tcgplayerEtchedId case final value?)
        'tcgplayer_etched_id': value,
      if (instance.cardmarketId case final value?) 'cardmarket_id': value,
      'oracle_id': instance.oracleId,
      'prints_search_uri': instance.printsSearchUri.toString(),
      'rulings_uri': instance.rulingsUri.toString(),
      'scryfall_uri': instance.scryfallUri.toString(),
      'uri': instance.uri.toString(),
      if (instance.allParts?.map((e) => e.toJson()).toList() case final value?)
        'all_parts': value,
      if (instance.cardFaces?.map((e) => e.toJson()).toList() case final value?)
        'card_faces': value,
      'cmc': instance.cmc,
      'color_identity':
          instance.colorIdentity.map((e) => _$ColorEnumMap[e]!).toList(),
      if (instance.colorIndicator?.map((e) => _$ColorEnumMap[e]!).toList()
          case final value?)
        'color_indicator': value,
      if (instance.colors?.map((e) => _$ColorEnumMap[e]!).toList()
          case final value?)
        'colors': value,
      if (instance.edhrecRank case final value?) 'edhrec_rank': value,
      if (instance.gameChanger case final value?) 'game_changer': value,
      if (instance.handModifier case final value?) 'hand_modifier': value,
      'keywords': instance.keywords,
      'layout': _$LayoutEnumMap[instance.layout]!,
      'legalities': instance.legalities.toJson(),
      if (instance.lifeModifier case final value?) 'life_modifier': value,
      if (instance.loyalty case final value?) 'loyalty': value,
      if (instance.manaCost case final value?) 'mana_cost': value,
      'name': instance.name,
      if (instance.oracleText case final value?) 'oracle_text': value,
      if (instance.pennyRank case final value?) 'penny_rank': value,
      'oversized': instance.oversized,
      if (instance.power case final value?) 'power': value,
      if (instance.producedMana?.map((e) => _$ColorEnumMap[e]!).toList()
          case final value?)
        'produced_mana': value,
      'reserved': instance.reserved,
      if (instance.toughness case final value?) 'toughness': value,
      'type_line': instance.typeLine,
      if (instance.artist case final value?) 'artist': value,
      if (instance.artistIds case final value?) 'artist_ids': value,
      if (instance.attractionLights case final value?)
        'attraction_lights': value,
      'booster': instance.booster,
      'border_color': _$BorderColorEnumMap[instance.borderColor]!,
      if (instance.cardBackId case final value?) 'card_back_id': value,
      'collector_number': instance.collectorNumber,
      if (instance.contentWarning case final value?) 'content_warning': value,
      'digital': instance.digital,
      'foil': instance.foil,
      'nonfoil': instance.nonfoil,
      'finishes': instance.finishes.map((e) => _$FinishEnumMap[e]!).toList(),
      if (instance.flavorName case final value?) 'flavor_name': value,
      if (instance.flavorText case final value?) 'flavor_text': value,
      if (instance.frameEffects?.map((e) => _$FrameEffectEnumMap[e]!).toList()
          case final value?)
        'frame_effects': value,
      'frame': _$FrameEnumMap[instance.frame]!,
      'full_art': instance.fullArt,
      'games': instance.games.map((e) => _$GameEnumMap[e]!).toList(),
      'highres_image': instance.highresImage,
      if (instance.illustrationId case final value?) 'illustration_id': value,
      'image_status': _$ImageStatusEnumMap[instance.imageStatus]!,
      if (instance.imageUris?.toJson() case final value?) 'image_uris': value,
      'prices': instance.prices.toJson(),
      if (instance.printedName case final value?) 'printed_name': value,
      if (instance.printedText case final value?) 'printed_text': value,
      if (instance.printedTypeLine case final value?)
        'printed_type_line': value,
      'promo': instance.promo,
      if (instance.promoTypes case final value?) 'promo_types': value,
      if (instance.purchaseUris?.map((k, e) => MapEntry(k, e.toString()))
          case final value?)
        'purchase_uris': value,
      'rarity': _$RarityEnumMap[instance.rarity]!,
      'related_uris':
          instance.relatedUris.map((k, e) => MapEntry(k, e.toString())),
      if (toDateString(instance.releasedAt) case final value?)
        'released_at': value,
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
      if (instance.variationOf case final value?) 'variation_of': value,
      if (_$SecurityStampEnumMap[instance.securityStamp] case final value?)
        'security_stamp': value,
      if (instance.watermark case final value?) 'watermark': value,
      if (instance.preview?.toJson() case final value?) 'preview': value,
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
  Language.quenya: 'qya',
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
