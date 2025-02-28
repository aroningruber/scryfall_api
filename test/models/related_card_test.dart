import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('RelatedCard', () {
    final id = 'b91e2431-500e-441a-881d-094ebef62283';
    final componentStr = 'combo_piece';
    final name = 'Eye of Vecna';
    final typeLine = 'Legendary Artifact';
    final uriStr =
        'https://api.scryfall.com/cards/b91e2431-500e-441a-881d-094ebef62283';

    final json = <String, dynamic>{
      'id': id,
      'component': componentStr,
      'name': name,
      'type_line': typeLine,
      'uri': uriStr,
    };

    group('fromJson', () {
      test('returns correct RelatedCard', () {
        final component = Component.comboPiece;
        final uri = Uri.parse(uriStr);

        expect(
          RelatedCard.fromJson(json),
          isA<RelatedCard>()
              .having((c) => c.id, 'id', id)
              .having((c) => c.component, 'component', component)
              .having((c) => c.name, 'name', name)
              .having((c) => c.typeLine, 'typeLine', typeLine)
              .having((c) => c.uri, 'uri', uri),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          RelatedCard.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
