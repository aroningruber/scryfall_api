import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('BulkData', () {
    group('fromJson', () {
      test('returns correct BulkData', () {
        final id = '6bbcf976-6369-4401-88fc-3a9e4984c305';
        final type = 'unique_artwork';
        final updatedAtStr = '2022-01-02T22:13:54.371+00:00';
        final uriStr =
            'https://api.scryfall.com/bulk-data/6bbcf976-6369-4401-88fc-3a9e4984c305';
        final name = 'Unique Artwork';
        final description =
            'A JSON file of Scryfall card objects that together contain all unique artworks. The chosen cards promote the best image scans.';
        final size = 16298744;
        final downloadUriStr =
            'https://c2.scryfall.com/file/scryfall-bulk/unique-artwork/unique-artwork-20220102221354.json';
        final contentType = 'application/json';
        final contentEncoding = 'gzip';

        final json = <String, dynamic>{
          'object': 'bulk_data',
          'id': id,
          'type': type,
          'updated_at': updatedAtStr,
          'uri': uriStr,
          'name': name,
          'description': description,
          'size': size,
          'download_uri': downloadUriStr,
          'content_type': contentType,
          'content_encoding': contentEncoding,
        };

        final updatedAt = DateTime.parse(updatedAtStr);
        final uri = Uri.parse(uriStr);
        final downloadUri = Uri.parse(downloadUriStr);

        expect(
          BulkData.fromJson(json),
          isA<BulkData>()
              .having((b) => b.id, 'id', id)
              .having((b) => b.type, 'type', type)
              .having((b) => b.updatedAt, 'updatedAt', updatedAt)
              .having((b) => b.uri, 'uri', uri)
              .having((b) => b.name, 'name', name)
              .having((b) => b.description, 'description', description)
              .having((b) => b.size, 'compressedSize', size)
              .having((b) => b.downloadUri, 'downloadUri', downloadUri)
              .having((b) => b.contentType, 'contentType', contentType)
              .having(
                  (b) => b.contentEncoding, 'contentEncoding', contentEncoding),
        );
      });
    });
  });
}
