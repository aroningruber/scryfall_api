import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('ImageUris', () {
    group('fromJson', () {
      test('returns correct ImageUris', () {
        final small_str =
            'https://c1.scryfall.com/file/scryfall-cards/small/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final normal_str =
            'https://c1.scryfall.com/file/scryfall-cards/normal/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final large_str =
            'https://c1.scryfall.com/file/scryfall-cards/large/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final png_str =
            'https://c1.scryfall.com/file/scryfall-cards/png/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.png?1627704426';
        final art_crop_str =
            'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final border_crop_str =
            'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';

        final json = <String, dynamic>{
          'small': small_str,
          'normal': normal_str,
          'large': large_str,
          'png': png_str,
          'art_crop': art_crop_str,
          'border_crop': border_crop_str,
        };

        final small = Uri.parse(small_str);
        final normal = Uri.parse(normal_str);
        final large = Uri.parse(large_str);
        final png = Uri.parse(png_str);
        final art_crop = Uri.parse(art_crop_str);
        final border_crop = Uri.parse(border_crop_str);

        expect(
          ImageUris.fromJson(json),
          isA<ImageUris>()
              .having((i) => i.small, 'small', small)
              .having((i) => i.normal, 'normal', normal)
              .having((i) => i.large, 'large', large)
              .having((i) => i.png, 'png', png)
              .having((i) => i.artCrop, 'artCrop  ', art_crop)
              .having((i) => i.borderCrop, 'borderCrop', border_crop),
        );
      });
    });
  });
}
