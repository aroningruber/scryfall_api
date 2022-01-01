import 'package:scryfall_api/scryfall_api.dart';
import 'package:test/test.dart';

void main() {
  group('CardIdentifier', () {
    group('fromJson', () {
      test('throws an Exception on invalid CardIdentifier', () {
        final json = <String, dynamic>{};
        expect(() => CardIdentifier.fromJson(json), throwsA(isA<Exception>()));
      });

      test('returns CardIdentifierId', () {
        final json = <String, dynamic>{'id': '42'};
        expect(CardIdentifier.fromJson(json), isA<CardIdentifierId>());
      });

      test('returns CardIdentifierMtgoId', () {
        final json = <String, dynamic>{'mtgo_id': 42};
        expect(CardIdentifier.fromJson(json), isA<CardIdentifierMtgoId>());
      });

      test('returns CardIdentifierMultiverseId', () {
        final json = <String, dynamic>{'multiverse_id': 42};
        expect(
          CardIdentifier.fromJson(json),
          isA<CardIdentifierMultiverseId>(),
        );
      });

      test('returns CardIdentifierOracleId', () {
        final json = <String, dynamic>{'oracle_id': '42'};
        expect(CardIdentifier.fromJson(json), isA<CardIdentifierOracleId>());
      });

      test('returns CardIdentifierIllustrationId', () {
        final json = <String, dynamic>{'illustration_id': '42'};
        expect(
          CardIdentifier.fromJson(json),
          isA<CardIdentifierIllustrationId>(),
        );
      });

      test('returns CardIdentifierName', () {
        final json = <String, dynamic>{'name': '42'};
        expect(CardIdentifier.fromJson(json), isA<CardIdentifierName>());
      });

      test('returns CardIdentifierSetName', () {
        final json = <String, dynamic>{'set': 'afr', 'name': '42'};
        expect(CardIdentifier.fromJson(json), isA<CardIdentifierSetName>());
      });

      test('returns CardIdentifierSetCollectorNumber', () {
        final json = <String, dynamic>{'set': 'afr', 'collector_number': '42'};
        expect(
          CardIdentifier.fromJson(json),
          isA<CardIdentifierSetCollectorNumber>(),
        );
      });
    });
  });

  group('CardIdentifierId', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierId('42');
        expect(
          CardIdentifierId.fromJson(identifier.toJson()),
          isA<CardIdentifierId>().having((c) => c.id, 'id', identifier.id),
        );
      });
    });
  });

  group('CardIdentifierMtgoId', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierMtgoId(42);
        expect(
          CardIdentifierMtgoId.fromJson(identifier.toJson()),
          isA<CardIdentifierMtgoId>()
              .having((c) => c.mtgoId, 'mtgoId', identifier.mtgoId),
        );
      });
    });
  });

  group('CardIdentifierMultiverseId', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierMultiverseId(42);
        expect(
          CardIdentifierMultiverseId.fromJson(identifier.toJson()),
          isA<CardIdentifierMultiverseId>().having(
            (c) => c.multiverseId,
            'multiverseId',
            identifier.multiverseId,
          ),
        );
      });
    });
  });

  group('CardIdentifierOracleId', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierOracleId('42');
        expect(
          CardIdentifierOracleId.fromJson(identifier.toJson()),
          isA<CardIdentifierOracleId>()
              .having((c) => c.oracleId, 'oracleId', identifier.oracleId),
        );
      });
    });
  });

  group('CardIdentifierIllustrationId', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierIllustrationId('42');
        expect(
          CardIdentifierIllustrationId.fromJson(identifier.toJson()),
          isA<CardIdentifierIllustrationId>().having(
            (c) => c.illustrationId,
            'illustrationId',
            identifier.illustrationId,
          ),
        );
      });
    });
  });

  group('CardIdentifierName', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierName('42');
        expect(
          CardIdentifierName.fromJson(identifier.toJson()),
          isA<CardIdentifierName>()
              .having((c) => c.name, 'name', identifier.name),
        );
      });
    });
  });

  group('CardIdentifierSetName', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierSetName('afr', '42');
        expect(
          CardIdentifierSetName.fromJson(identifier.toJson()),
          isA<CardIdentifierSetName>()
              .having((c) => c.set, 'set', identifier.set)
              .having((c) => c.name, 'name', identifier.name),
        );
      });
    });
  });

  group('CardIdentifierSetCollectorNumber', () {
    group('fromJson/toJson', () {
      test('work properly', () {
        const identifier = CardIdentifierSetCollectorNumber('afr', '42');
        expect(
          CardIdentifierSetCollectorNumber.fromJson(identifier.toJson()),
          isA<CardIdentifierSetCollectorNumber>()
              .having((c) => c.set, 'set', identifier.set)
              .having(
                (c) => c.collectorNumber,
                'collectorNumber',
                identifier.collectorNumber,
              ),
        );
      });
    });
  });
}
