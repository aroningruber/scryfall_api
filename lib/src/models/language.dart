import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

/// Languages supported by the [Scryfall API](https://scryfall.com)
@JsonEnum(alwaysCreate: true)
enum Language {
  @JsonValue('en')
  english,
  @JsonValue('es')
  spanish,
  @JsonValue('fr')
  french,
  @JsonValue('de')
  german,
  @JsonValue('it')
  italian,
  @JsonValue('pt')
  portuguese,
  @JsonValue('ja')
  japanese,
  @JsonValue('ko')
  korean,
  @JsonValue('ru')
  russian,
  @JsonValue('zhs')
  chineseSimplified,
  @JsonValue('zht')
  chineseTraditional,
  @JsonValue('he')
  hebrew,
  @JsonValue('la')
  latin,
  @JsonValue('grc')
  ancientGreek,
  @JsonValue('ar')
  arabic,
  @JsonValue('sa')
  sanskrit,
  @JsonValue('ph')
  phyrexian,
  unknown,
}

extension LanguageCodeConversion on Language {
  /// The 2-3 letter language code of the language.
  String get name => _$LanguageEnumMap[this] ?? 'unknown';
}
