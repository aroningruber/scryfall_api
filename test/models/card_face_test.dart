import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('CardFace', () {
    group('fromJson', () {
      test('returns correct CardFace', () {
        final name = 'Henrika Domnathi';
        final flavor_name = 'The Three Weird Sisters';
        final printed_name = 'The Three Weird Sisters';
        final mana_cost = '{2}{B}{B}';
        final type_line = 'Legendary Creature — Vampire';
        final oracle_text =
            'Flying\nAt the beginning of combat on your turn, choose one that hasn\'t been chosen —\n• Each player sacrifices a creature.\n• You draw a card and you lose 1 life.\n• Transform Henrika Domnathi.';
        final colors_str = ['B'];
        final power = '1';
        final toughness = '3';
        final artist = 'Nils Hamm';
        final artist_id = 'c540d1fc-1500-457f-93cf-d6069ee66546';
        final illustration_id = '7ea5f6c8-7bf9-4a90-97c8-34aa0db567c9';
        final image_uris_str = <String, dynamic>{
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
          'object': 'card_face',
          'name': name,
          'flavor_name': flavor_name,
          'printed_name': printed_name,
          'mana_cost': mana_cost,
          'type_line': type_line,
          'oracle_text': oracle_text,
          'colors': colors_str,
          'power': power,
          'toughness': toughness,
          'artist': artist,
          'artist_id': artist_id,
          'illustration_id': illustration_id,
          'image_uris': image_uris_str,
        };

        final colors = [Color.black];

        expect(
          CardFace.fromJson(json),
          isA<CardFace>()
              .having((c) => c.name, 'name', name)
              .having((c) => c.flavorName, 'flavorName', flavor_name)
              .having((c) => c.printedName, 'printedName', printed_name)
              .having((c) => c.manaCost, 'manaCost', mana_cost)
              .having((c) => c.oracleText, 'oracleText', oracle_text)
              .having((c) => c.colors, 'colors', colors)
              .having((c) => c.power, 'power', power)
              .having((c) => c.toughness, 'toughness', toughness)
              .having((c) => c.artist, 'artist', artist)
              .having((c) => c.artistId, 'artistId', artist_id)
              .having(
                (c) => c.illustrationId,
                'illustrationId',
                illustration_id,
              )
              .having((c) => c.imageUris, 'imageUris', isA<ImageUris>()),
        );
      });
    });
  });
}
