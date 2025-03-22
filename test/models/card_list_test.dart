import 'dart:convert';
import 'dart:io';

import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('CardList', () {
    late File file;
    late dynamic cardStr;
    late List<Map<String, String>> notFound;
    late List<dynamic> data;
    late Map<String, dynamic> json;

    setUp(() async {
      file = File('test/mock_data/card_list_card.json');
      cardStr = jsonDecode(await file.readAsString());
      notFound = [
        {'id': '42'},
        {'set': 'afr', 'name': '42'},
      ];
      data = [cardStr];

      json = <String, dynamic>{
        'object': 'list',
        'not_found': notFound,
        'data': data,
      };
    });
    group('fromJson', () {
      test('returns correct CardList', () {
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
    group("toJson", () {
      test("returns correct JSON", () {
        expect(
          CardList.fromJson(json).toJson(),
          json,
        );
      });
    });
  });
}
