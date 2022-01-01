import 'package:json_annotation/json_annotation.dart';

part 'card_identifier.g.dart';

abstract class CardIdentifier {
  factory CardIdentifier.fromJson(Map<String, dynamic> json) {
    if (json.isId) {
      return CardIdentifierId.fromJson(json);
    } else if (json.isMtgoId) {
      return CardIdentifierMtgoId.fromJson(json);
    } else if (json.isMultiverseId) {
      return CardIdentifierMultiverseId.fromJson(json);
    } else if (json.isOracleId) {
      return CardIdentifierOracleId.fromJson(json);
    } else if (json.isIllustrationId) {
      return CardIdentifierIllustrationId.fromJson(json);
    } else if (json.isName) {
      return CardIdentifierName.fromJson(json);
    } else if (json.isSetName) {
      return CardIdentifierSetName.fromJson(json);
    } else if (json.isSetCollectorNumber) {
      return CardIdentifierSetCollectorNumber.fromJson(json);
    } else {
      throw Exception('Unknown CardIdentifier');
    }
  }

  Map<String, dynamic> toJson();
}

/// Finds a card with the specified Scryfall `id`.
@JsonSerializable(createToJson: true)
class CardIdentifierId implements CardIdentifier {
  /// The Scryfall `id` of a card.
  final String id;

  /// Constructs a [CardIdentifierId] by settings its properties.
  const CardIdentifierId(this.id);

  /// Constructs a [CardIdentifierId] from JSON.
  factory CardIdentifierId.fromJson(Map<String, dynamic> json) =>
      _$CardIdentifierIdFromJson(json);

  /// Converts a [CardIdentifierId] to JSON.
  @override
  Map<String, dynamic> toJson() => _$CardIdentifierIdToJson(this);
}

/// Finds a card with the specified `mtgo_id` or `mtgo_foil_id`.
@JsonSerializable(createToJson: true)
class CardIdentifierMtgoId implements CardIdentifier {
  /// The `mtgo_id` or `mtgo_foil_id` of a card.
  final int mtgoId;

  /// Constructs a [CardIdentifierMtgoId] by settings its properties.
  const CardIdentifierMtgoId(this.mtgoId);

  /// Constructs a [CardIdentifierMtgoId] from JSON.
  factory CardIdentifierMtgoId.fromJson(Map<String, dynamic> json) =>
      _$CardIdentifierMtgoIdFromJson(json);

  /// Converts a [CardIdentifierMtgoId] to JSON.
  @override
  Map<String, dynamic> toJson() => _$CardIdentifierMtgoIdToJson(this);
}

/// Finds a card with the specified value among its `multiverse_ids`.
@JsonSerializable(createToJson: true)
class CardIdentifierMultiverseId implements CardIdentifier {
  /// The `multiverse_id` of a card.
  final int multiverseId;

  /// Constructs a [CardIdentifierMultiverseId] by settings its properties.
  const CardIdentifierMultiverseId(this.multiverseId);

  /// Constructs a [CardIdentifierMultiverseId] from JSON.
  factory CardIdentifierMultiverseId.fromJson(Map<String, dynamic> json) =>
      _$CardIdentifierMultiverseIdFromJson(json);

  /// Converts a [CardIdentifierMultiverseId] to JSON.
  @override
  Map<String, dynamic> toJson() => _$CardIdentifierMultiverseIdToJson(this);
}

/// Finds the newest edition of cards with the specified `oracle_id`.
@JsonSerializable(createToJson: true)
class CardIdentifierOracleId implements CardIdentifier {
  /// The `oracle_id` of a card.
  final String oracleId;

  /// Constructs a [CardIdentifierOracleId] by settings its properties.
  const CardIdentifierOracleId(this.oracleId);

  /// Constructs a [CardIdentifierOracleId] from JSON.
  factory CardIdentifierOracleId.fromJson(Map<String, dynamic> json) =>
      _$CardIdentifierOracleIdFromJson(json);

  /// Converts a [CardIdentifierOracleId] to JSON.
  @override
  Map<String, dynamic> toJson() => _$CardIdentifierOracleIdToJson(this);
}

/// Finds the preferred scans of cards with the specified `illustration_id`.
@JsonSerializable(createToJson: true)
class CardIdentifierIllustrationId implements CardIdentifier {
  /// The `illustration_id` of a card.
  final String illustrationId;

  /// Constructs a [CardIdentifierIllustrationId] by settings its properties.
  const CardIdentifierIllustrationId(this.illustrationId);

  /// Constructs a [CardIdentifierIllustrationId] from JSON.
  factory CardIdentifierIllustrationId.fromJson(Map<String, dynamic> json) =>
      _$CardIdentifierIllustrationIdFromJson(json);

  /// Converts a [CardIdentifierIllustrationId] to JSON.
  @override
  Map<String, dynamic> toJson() => _$CardIdentifierIllustrationIdToJson(this);
}

/// Finds the newest edition of a card with the specified `name`.
@JsonSerializable(createToJson: true)
class CardIdentifierName implements CardIdentifier {
  /// The `name` of a card.
  final String name;

  /// Constructs a [CardIdentifierName] by settings its properties.
  const CardIdentifierName(this.name);

  /// Constructs a [CardIdentifierName] from JSON.
  factory CardIdentifierName.fromJson(Map<String, dynamic> json) =>
      _$CardIdentifierNameFromJson(json);

  /// Converts a [CardIdentifierName] to JSON.
  @override
  Map<String, dynamic> toJson() => _$CardIdentifierNameToJson(this);
}

/// Finds a card matching the specified `set` and `name`.
@JsonSerializable(createToJson: true)
class CardIdentifierSetName implements CardIdentifier {
  /// The `set` code of a card.
  final String set;

  /// The `name` of a card.
  final String name;

  /// Constructs a [CardIdentifierSetName] by settings its properties.
  const CardIdentifierSetName(this.set, this.name);

  /// Constructs a [CardIdentifierSetName] from JSON.
  factory CardIdentifierSetName.fromJson(Map<String, dynamic> json) =>
      _$CardIdentifierSetNameFromJson(json);

  /// Converts a [CardIdentifierSetName] to JSON.
  @override
  Map<String, dynamic> toJson() => _$CardIdentifierSetNameToJson(this);
}

/// Finds a card with the specified `set` and `collector_number`.
@JsonSerializable(createToJson: true)
class CardIdentifierSetCollectorNumber implements CardIdentifier {
  /// The `set` code of a card.
  final String set;

  /// The `collector_number` of a card.
  final String collectorNumber;

  /// Constructs a [CardIdentifierSetCollectorNumber] by settings
  /// its properties.
  const CardIdentifierSetCollectorNumber(this.set, this.collectorNumber);

  /// Constructs a [CardIdentifierSetCollectorNumber] from JSON.
  factory CardIdentifierSetCollectorNumber.fromJson(
          Map<String, dynamic> json) =>
      _$CardIdentifierSetCollectorNumberFromJson(json);

  /// Converts a [CardIdentifierSetCollectorNumber] to JSON.
  @override
  Map<String, dynamic> toJson() =>
      _$CardIdentifierSetCollectorNumberToJson(this);
}

extension on Map<String, dynamic> {
  bool get isId => keys.length == 1 && containsKey('id');
  bool get isMtgoId => keys.length == 1 && containsKey('mtgo_id');
  bool get isMultiverseId => keys.length == 1 && containsKey('multiverse_id');
  bool get isOracleId => keys.length == 1 && containsKey('oracle_id');
  bool get isIllustrationId =>
      keys.length == 1 && containsKey('illustration_id');
  bool get isName => keys.length == 1 && containsKey('name');
  bool get isSetName =>
      keys.length == 2 && containsKey('set') && containsKey('name');
  bool get isSetCollectorNumber =>
      keys.length == 2 && containsKey('set') && containsKey('collector_number');
}
