import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('ImageUris', () {
    group('fromJson', () {
      test('returns correct ImageUris', () {
        final smallStr =
            'https://c1.scryfall.com/file/scryfall-cards/small/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final normalStr =
            'https://c1.scryfall.com/file/scryfall-cards/normal/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final largeStr =
            'https://c1.scryfall.com/file/scryfall-cards/large/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final pngStr =
            'https://c1.scryfall.com/file/scryfall-cards/png/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.png?1627704426';
        final artCropStr =
            'https://c1.scryfall.com/file/scryfall-cards/art_crop/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';
        final borderCropStr =
            'https://c1.scryfall.com/file/scryfall-cards/border_crop/front/0/5/05dcff61-8c48-401f-a31f-5fc53a298356.jpg?1627704426';

        final json = <String, dynamic>{
          'small': smallStr,
          'normal': normalStr,
          'large': largeStr,
          'png': pngStr,
          'art_crop': artCropStr,
          'border_crop': borderCropStr,
        };

        final small = Uri.parse(smallStr);
        final normal = Uri.parse(normalStr);
        final large = Uri.parse(largeStr);
        final png = Uri.parse(pngStr);
        final artCrop = Uri.parse(artCropStr);
        final borderCrop = Uri.parse(borderCropStr);

        expect(
          ImageUris.fromJson(json),
          isA<ImageUris>()
              .having((i) => i.small, 'small', small)
              .having((i) => i.normal, 'normal', normal)
              .having((i) => i.large, 'large', large)
              .having((i) => i.png, 'png', png)
              .having((i) => i.artCrop, 'artCrop  ', artCrop)
              .having((i) => i.borderCrop, 'borderCrop', borderCrop),
        );
      });
    });
  });
}
