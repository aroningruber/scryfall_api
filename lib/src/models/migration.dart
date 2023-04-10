import 'package:json_annotation/json_annotation.dart';

part 'migration.g.dart';

///  Endpoints to help you reconcile downstream data you may have synced
/// or imported from Scryfall
@JsonSerializable()
class Migration {
  /// A unique ID for this card migration.
  final String id;

  /// The Scryfall URI for the current object.
  final String uri;

  /// The date the migration was performed.
  final String performedAt;

  /// A computer-readable indicator of the migration strategy.
  final String migrationStrategy;

  /// The id of the affected API Card object.
  final String oldScryfallId;

  /// The replacement id of hte API card object if this is a [merge].
  final String? newScryfallId;

  /// A note left by the Scryfall team about this migration.
  final String note;

  const Migration({
    required this.id,
    required this.uri,
    required this.performedAt,
    required this.migrationStrategy,
    required this.oldScryfallId,
    required this.newScryfallId,
    required this.note,
  });

  /// Constructs a [Migration] object from JSON.
  factory Migration.fromJson(Map<String, dynamic> json) =>
      _$MigrationFromJson(json);
}
