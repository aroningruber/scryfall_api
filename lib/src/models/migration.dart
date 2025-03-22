import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'migration.g.dart';

/// A [Migration] object helps to reconcile downstream data that may have
/// been synced or imported from Scryfall.
///
/// In rare instances, it may be discovered that a card in the Scryfall database
/// does not really exist or has been removed from a digital game permanantly.
@JsonSerializable()
class Migration {
  /// A unique ID for this card migration.
  final String id;

  /// The Scryfall URI for the current object.
  final String uri;

  /// The date the migration was performed.
  final DateTime performedAt;

  /// A computer-readable indicator of the migration strategy.
  @JsonKey(unknownEnumValue: MigrationStrategy.unknown)
  final MigrationStrategy migrationStrategy;

  /// The id of the affected API Card object.
  final String oldScryfallId;

  /// The replacement id of the API card object if this is a
  /// [MigrationStrategy.merge].
  final String? newScryfallId;

  /// A note left by the Scryfall team about this migration.
  final String? note;

  const Migration({
    required this.id,
    required this.uri,
    required this.performedAt,
    required this.migrationStrategy,
    required this.oldScryfallId,
    this.newScryfallId,
    this.note,
  });

  /// Constructs a [Migration] object from JSON.
  factory Migration.fromJson(Map<String, dynamic> json) =>
      _$MigrationFromJson(json);

  /// Constant discriminator for object type.
  @JsonKey(includeFromJson: false, includeToJson: true)
  String get object => 'migration';

  /// Converts this [Migration] object to JSON.
  Map<String, dynamic> toJson() => _$MigrationToJson(this);
}
