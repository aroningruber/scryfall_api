// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtg_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MtgSet _$MtgSetFromJson(Map<String, dynamic> json) => $checkedCreate(
      'MtgSet',
      json,
      ($checkedConvert) {
        final val = MtgSet(
          id: $checkedConvert('id', (v) => v as String),
          code: $checkedConvert('code', (v) => v as String),
          mtgoCode: $checkedConvert('mtgo_code', (v) => v as String?),
          arenaCode: $checkedConvert('arena_code', (v) => v as String?),
          tcgplayerId: $checkedConvert('tcgplayer_id', (v) => v as int?),
          name: $checkedConvert('name', (v) => v as String),
          setType: $checkedConvert(
              'set_type',
              (v) => $enumDecode(_$SetTypeEnumMap, v,
                  unknownValue: SetType.unknown)),
          releasedAt: $checkedConvert('released_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          blockCode: $checkedConvert('block_code', (v) => v as String?),
          block: $checkedConvert('block', (v) => v as String?),
          parentSetCode:
              $checkedConvert('parent_set_code', (v) => v as String?),
          cardCount: $checkedConvert('card_count', (v) => v as int),
          printedSize: $checkedConvert('printed_size', (v) => v as int?),
          digital: $checkedConvert('digital', (v) => v as bool),
          foilOnly: $checkedConvert('foil_only', (v) => v as bool),
          nonfoilOnly: $checkedConvert('nonfoil_only', (v) => v as bool),
          scryfallUri:
              $checkedConvert('scryfall_uri', (v) => Uri.parse(v as String)),
          uri: $checkedConvert('uri', (v) => Uri.parse(v as String)),
          iconSvgUri:
              $checkedConvert('icon_svg_uri', (v) => Uri.parse(v as String)),
          searchUri:
              $checkedConvert('search_uri', (v) => Uri.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'mtgoCode': 'mtgo_code',
        'arenaCode': 'arena_code',
        'tcgplayerId': 'tcgplayer_id',
        'setType': 'set_type',
        'releasedAt': 'released_at',
        'blockCode': 'block_code',
        'parentSetCode': 'parent_set_code',
        'cardCount': 'card_count',
        'printedSize': 'printed_size',
        'foilOnly': 'foil_only',
        'nonfoilOnly': 'nonfoil_only',
        'scryfallUri': 'scryfall_uri',
        'iconSvgUri': 'icon_svg_uri',
        'searchUri': 'search_uri'
      },
    );

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
