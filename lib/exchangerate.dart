// To parse this JSON data, do
//
//     final exchangeRate = exchangeRateFromJson(jsonString);

import 'dart:convert';

ExchangeRate exchangeRateFromJson(String str) =>
    ExchangeRate.fromJson(json.decode(str));

String exchangeRateToJson(ExchangeRate data) => json.encode(data.toJson());

class ExchangeRate {
  ExchangeRate({
    required this.provider,
    required this.warningUpgradeToV6,
    required this.terms,
    required this.base,
    required this.date,
    required this.timeLastUpdated,
    required this.rates,
  });

  String? provider;
  String? warningUpgradeToV6;
  String? terms;
  String? base;
  DateTime? date;
  int? timeLastUpdated;
  Map<String, double>? rates;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        provider: json["provider"] == null ? null : json["provider"],
        warningUpgradeToV6: json["WARNING_UPGRADE_TO_V6"] == null
            ? null
            : json["WARNING_UPGRADE_TO_V6"],
        terms: json["terms"] == null ? null : json["terms"],
        base: json["base"] == null ? null : json["base"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeLastUpdated: json["time_last_updated"] == null
            ? null
            : json["time_last_updated"],
        rates: json["rates"] == null
            ? null
            : Map.from(json["rates"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider == null ? null : provider,
        "WARNING_UPGRADE_TO_V6":
            warningUpgradeToV6 == null ? null : warningUpgradeToV6,
        "terms": terms == null ? null : terms,
        "base": base == null ? null : base,
        "date": date == null
            ? null
            : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time_last_updated": timeLastUpdated == null ? null : timeLastUpdated,
        "rates": rates == null
            ? null
            : Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
