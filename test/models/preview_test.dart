import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('Preview', () {
    final source = 'Wizards of the Coast';
    final sourceUriStr =
        'https://magic.wizards.com/en/articles/archive/card-preview/henrika-domnathi-2021-11-02';
    final previewedAtStr = '2021-11-02T00:00:00.000';

    final json = <String, dynamic>{
      'source': source,
      'source_uri': sourceUriStr,
      'previewed_at': previewedAtStr,
    };

    group('fromJson', () {
      test('returns correct Preview', () {
        final sourceUri = Uri.parse(sourceUriStr);
        final previewedAt = DateTime.parse(previewedAtStr);

        expect(
          Preview.fromJson(json),
          isA<Preview>()
              .having((p) => p.previewedAt, 'previewedAt', previewedAt)
              .having((p) => p.sourceUri, 'sourceUri', sourceUri)
              .having((p) => p.source, 'source', source),
        );
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          Preview.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
