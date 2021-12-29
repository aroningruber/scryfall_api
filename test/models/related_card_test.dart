import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('RelatedCard', () {
    group('fromJson', () {
      test('returns correct RelatedCard', () {
        final id = 'b91e2431-500e-441a-881d-094ebef62283';
        final component_str = 'combo_piece';
        final name = 'Eye of Vecna';
        final type_line = 'Legendary Artifact';
        final uri_str =
            'https://api.scryfall.com/cards/b91e2431-500e-441a-881d-094ebef62283';

        final json = <String, dynamic>{
          'object': 'related_card',
          'id': id,
          'component': component_str,
          'name': name,
          'type_line': type_line,
          'uri': uri_str,
        };

        final component = Component.comboPiece;
        final uri = Uri.parse(uri_str);

        expect(
          RelatedCard.fromJson(json),
          isA<RelatedCard>()
              .having((c) => c.id, 'id', id)
              .having((c) => c.component, 'component', component)
              .having((c) => c.name, 'name', name)
              .having((c) => c.typeLine, 'typeLine', type_line)
              .having((c) => c.uri, 'uri', uri),
        );
      });
    });
  });
}
