import 'package:json_annotation/json_annotation.dart';

part 'prices.g.dart';

/// The prices of a card in different currencies.
@JsonSerializable()
class Prices {
  /// The price of the non-foil card in dollar.
  final String? usd;

  /// The price of the foil card in dollar.
  final String? usdFoil;

  /// The price of the etched card in dollar.
  final String? usdEtched;

  /// The price of the non-foil card in euro.
  final String? eur;

  /// The price of the foil card in euro.
  final String? eurFoil;

  /// The price of the card in tix.
  final String? tix;

  /// Constructs a [Prices] object by setting its properties.
  const Prices({
    this.usd,
    this.usdFoil,
    this.usdEtched,
    this.eur,
    this.eurFoil,
    this.tix,
  });

  /// Constructs a [Prices] object from JSON.
  factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);
}
