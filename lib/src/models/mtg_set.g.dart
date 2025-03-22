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
          tcgplayerId:
              $checkedConvert('tcgplayer_id', (v) => (v as num?)?.toInt()),
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
          cardCount: $checkedConvert('card_count', (v) => (v as num).toInt()),
          printedSize:
              $checkedConvert('printed_size', (v) => (v as num?)?.toInt()),
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

Map<String, dynamic> _$MtgSetToJson(MtgSet instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      if (instance.mtgoCode case final value?) 'mtgo_code': value,
      if (instance.arenaCode case final value?) 'arena_code': value,
      if (instance.tcgplayerId case final value?) 'tcgplayer_id': value,
      'name': instance.name,
      'set_type': _$SetTypeEnumMap[instance.setType]!,
      if (toDateString(instance.releasedAt) case final value?)
        'released_at': value,
      if (instance.blockCode case final value?) 'block_code': value,
      if (instance.block case final value?) 'block': value,
      if (instance.parentSetCode case final value?) 'parent_set_code': value,
      'card_count': instance.cardCount,
      if (instance.printedSize case final value?) 'printed_size': value,
      'digital': instance.digital,
      'foil_only': instance.foilOnly,
      'nonfoil_only': instance.nonfoilOnly,
      'scryfall_uri': instance.scryfallUri.toString(),
      'uri': instance.uri.toString(),
      'icon_svg_uri': instance.iconSvgUri.toString(),
      'search_uri': instance.searchUri.toString(),
      'object': instance.object,
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
