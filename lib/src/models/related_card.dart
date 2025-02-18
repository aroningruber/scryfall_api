import 'package:json_annotation/json_annotation.dart';

part 'related_card.g.dart';

/// A [Component] explains the relationship between a card
/// and the [RelatedCard] it references.
@JsonEnum(fieldRename: FieldRename.snake)
enum Component {
  /// A token.
  token,

  /// A part for melding.
  meldPart,

  /// A result of melding.
  meldResult,

  /// A piece used for combinations.
  comboPiece,
}

/// Cards that are closely related to other cards (because they call
/// them by name, or generate a token, or meld, etc) have a `all_parts`
/// property that contains Related Card objects.
@JsonSerializable()
class RelatedCard {
  /// An unique ID for this card in Scryfall’s database.
  final String id;

  /// A field explaining what role this card plays in this relationship.
  final Component component;

  /// The name of this particular related card.
  final String name;

  /// The type line of this card.
  final String typeLine;

  /// A URI where you can retrieve a full object describing this card
  /// on Scryfall’s API.
  final Uri uri;

  /// Constructs a [RelatedCard] by setting its properties.
  const RelatedCard({
    required this.id,
    required this.component,
    required this.name,
    required this.typeLine,
    required this.uri,
  });

  /// Constructs a [RelatedCard] from JSON.
  factory RelatedCard.fromJson(Map<String, dynamic> json) =>
      _$RelatedCardFromJson(json);

  /// Converts this [RelatedCard] to JSON.
  Map<String, dynamic> toJson() => _$RelatedCardToJson(this);
}
