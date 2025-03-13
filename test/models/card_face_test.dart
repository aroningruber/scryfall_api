import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('CardFace', () {
    final name = 'Henrika Domnathi';
    final flavorName = 'The Three Weird Sisters';
    final flavorText = 'The Three Weird Sisters';
    final printedName = 'The Three Weird Sisters';
    final printedText =
        'Flying\nAt the beginning of combat on your turn, choose one that hasn\'t been chosen —\n• Each player sacrifices a creature.\n• You draw a card and you lose 1 life.\n• Transform Henrika Domnathi.';
    final manaCost = '{2}{B}{B}';
    final typeLine = 'Legendary Creature — Vampire';
    final oracleText =
        'Flying\nAt the beginning of combat on your turn, choose one that hasn\'t been chosen —\n• Each player sacrifices a creature.\n• You draw a card and you lose 1 life.\n• Transform Henrika Domnathi.';
    final oracleId = '7ea5f6c8-7bf9-4a90-97c8-34aa0db567c9';
    final colorIndicatorStr = ['G', 'U'];
    final colorsStr = ['B'];
    final power = '1';
    final toughness = '3';
    final cmc = 4.0;
    final defense = '3';
    final loyalty = '0';
    final layout = Layout.transform.name;
    final watermark = "Innistrad";
    final artist = 'Nils Hamm';
    final artistId = 'c540d1fc-1500-457f-93cf-d6069ee66546';
    final illustrationId = '7ea5f6c8-7bf9-4a90-97c8-34aa0db567c9';
    final imageUrisStr = <String, dynamic>{
      'small':
          'https://c1.scryfall.com/file/scryfall-cards/small/front/a/a/aafe47a8-0223-4c0b-b6ce-e25446a07c96.jpg?1636756882',
      'normal':
          'https://c1.scryfall.com/file/scryfall-cards/normal/front/a/a/aafe47a8-0223-4c0b-b6ce-e25446a07c96.jpg?1636756882',
      'large':
          'https://c1.scryfall.com/file/scryfall-cards/large/front/a/a/aafe47a8-0223-4c0b-b6ce-e25446a07c96.jpg?1636756882',
      'png':
          'https://c1.scryfall.com/file/scryfall-cards/png/front/a/a/aafe47a8-0223-4c0b-b6ce-e25446a07c96.png?1636756882',
      'art_crop':
          'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/a/a/aafe47a8-0223-4c0b-b6ce-e25446a07c96.jpg?1636756882',
      'border_crop':
          'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/a/a/aafe47a8-0223-4c0b-b6ce-e25446a07c96.jpg?1636756882',
    };

    final json = <String, dynamic>{
      'name': name,
      'flavor_name': flavorName,
      'printed_name': printedName,
      'printed_text': printedText,
      'flavor_text': flavorText,
      'mana_cost': manaCost,
      'type_line': typeLine,
      'oracle_text': oracleText,
      'color_indicator': colorIndicatorStr,
      'colors': colorsStr,
      'power': power,
      'toughness': toughness,
      'artist': artist,
      'artist_id': artistId,
      'illustration_id': illustrationId,
      'image_uris': imageUrisStr,
      'cmc': cmc,
      'layout': layout,
      'loyalty': loyalty,
      'defense': defense,
      'watermark': watermark,
      'oracle_id': oracleId,
      'printed_type_line': 'Legendary Creature — Vampire',
    };

    final colorIndicator = [Color.green, Color.blue];
    final colors = [Color.black];
    group('fromJson', () {
      test('returns correct CardFace', () {
        expect(
          CardFace.fromJson(json),
          isA<CardFace>()
              .having((c) => c.name, 'name', name)
              .having((c) => c.flavorName, 'flavorName', flavorName)
              .having((c) => c.printedName, 'printedName', printedName)
              .having((c) => c.manaCost, 'manaCost', manaCost)
              .having((c) => c.oracleText, 'oracleText', oracleText)
              .having((c) => c.cmc, 'cmc', cmc)
              .having((c) => c.layout, 'layout', Layout.transform)
              .having((c) => c.loyalty, 'loyalty', loyalty)
              .having((c) => c.defense, 'defense', defense)
              .having((c) => c.watermark, 'watermark', watermark)
              .having((c) => c.oracleId, 'oracleId', oracleId)
              .having((c) => c.printedText, 'printedText', printedText)
              .having(
                (c) => c.colorIndicator,
                'colorIndicator',
                colorIndicator,
              )
              .having((c) => c.colors, 'colors', colors)
              .having((c) => c.power, 'power', power)
              .having((c) => c.toughness, 'toughness', toughness)
              .having((c) => c.artist, 'artist', artist)
              .having((c) => c.artistId, 'artistId', artistId)
              .having(
                (c) => c.illustrationId,
                'illustrationId',
                illustrationId,
              )
              .having((c) => c.imageUris, 'imageUris', isA<ImageUris>()),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        final cardFace = CardFace.fromJson(json);
        expect(cardFace.toJson(), json);
      });
    });
  });
}
