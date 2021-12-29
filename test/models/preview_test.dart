import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Preview', () {
    group('fromJson', () {
      test('returns correct Preview', () {
        final source = 'Wizards of the Coast';
        final source_uri_str =
            'https://magic.wizards.com/en/articles/archive/card-preview/henrika-domnathi-2021-11-02';
        final previewed_at_str = '2021-11-02';

        final json = <String, dynamic>{
          'source': source,
          'source_uri': source_uri_str,
          'previewed_at': previewed_at_str,
        };

        final source_uri = Uri.parse(source_uri_str);
        final previewed_at = DateTime.parse(previewed_at_str);

        expect(
          Preview.fromJson(json),
          isA<Preview>()
              .having((p) => p.previewedAt, 'previewedAt', previewed_at)
              .having((p) => p.sourceUri, 'sourceUri', source_uri)
              .having((p) => p.source, 'source', source),
        );
      });
    });
  });
}
