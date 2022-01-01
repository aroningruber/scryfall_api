import 'dart:convert';
import 'dart:io';

import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('CardList', () {
    group('fromJson', () {
      test('returns correct CardList', () async {
        final file = File('test/mock_data/card_list_card.json');
        final cardStr = jsonDecode(await file.readAsString());
        final notFound = [
          {'id': '42'},
          {'set': 'afr', 'name': '42'},
        ];
        final data = [cardStr];

        final json = <String, dynamic>{
          'object': 'list',
          'not_found': notFound,
          'data': data,
        };

        expect(
          CardList.fromJson(json),
          isA<CardList>()
              .having(
                (c) => c.notFound,
                'notFound',
                isA<List<CardIdentifier>>()
                    .having((l) => l[0], 'first', isA<CardIdentifierId>())
                    .having(
                        (l) => l[1], 'second', isA<CardIdentifierSetName>()),
              )
              .having((c) => c.data, 'data', isA<List<MtgCard>>())
              .having((c) => c.length, 'length', data.length)
              .having((c) => c[0], 'first', isA<MtgCard>()),
        );
      });
    });
  });
}
