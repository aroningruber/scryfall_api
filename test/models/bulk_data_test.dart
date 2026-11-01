import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('BulkData', () {
    final id = '6bbcf976-6369-4401-88fc-3a9e4984c305';
    final type = 'unique_artwork';
    final updatedAtStr = '2026-11-01T10:03:15.962Z';
    final uriStr =
        'https://api.scryfall.com/bulk-data/6bbcf976-6369-4401-88fc-3a9e4984c305';
    final name = 'Unique Artwork';
    final description =
        'A JSON file of Scryfall card objects that together contain all unique artworks. The chosen cards promote the best image scans.';
    final jsonlDownloadUriStr =
        'https://data.scryfall.io/unique-artwork/unique-artwork-20261101100315.jsonl.gz';
    final compressedSize = 39026750;

    final json = <String, dynamic>{
      'object': 'bulk_data',
      'id': id,
      'type': type,
      'updated_at': updatedAtStr,
      'uri': uriStr,
      'name': name,
      'description': description,
      'jsonl_download_uri': jsonlDownloadUriStr,
      'compressed_size': compressedSize,
    };

    group('fromJson', () {
      test('returns correct BulkData', () {
        final updatedAt = DateTime.parse(updatedAtStr);
        final uri = Uri.parse(uriStr);
        final jsonlDownloadUri = Uri.parse(jsonlDownloadUriStr);

        expect(
            BulkData.fromJson(json),
            isA<BulkData>()
                .having((b) => b.id, 'id', id)
                .having((b) => b.type, 'type', type)
                .having((b) => b.updatedAt, 'updatedAt', updatedAt)
                .having((b) => b.uri, 'uri', uri)
                .having((b) => b.name, 'name', name)
                .having((b) => b.description, 'description', description)
                .having(
                    (b) => b.compressedSize, 'compressedSize', compressedSize)
                .having((b) => b.jsonlDownloadUri, 'jsonlDownloadUri',
                    jsonlDownloadUri));
      });
    });

    group("toJson", () {
      test("returns correct JSON", () {
        final bulkData = BulkData.fromJson(json);
        expect(bulkData.toJson(), json);
      });
    });
  });
}
