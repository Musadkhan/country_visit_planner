import 'package:hive/hive.dart';

part 'CountryResponseModel.g.dart';

@HiveType(typeId: 0)
class CountryResponseModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String officialName;

  @HiveField(2)
  final String? nativeName;

  @HiveField(3)
  final String capital;

  @HiveField(4)
  final String region;

  @HiveField(5)
  final String flagUrl;

  @HiveField(6)
  final String currencyName;

  @HiveField(7)
  final String currencySymbol;

  @HiveField(8)
  final String phoneCode;

  @HiveField(9)
  final double area;

  @HiveField(10)
  final int population;

  @HiveField(11)
  final double lat;

  @HiveField(12)
  final double lng;

  CountryResponseModel({
    required this.name,
    required this.officialName,
    this.nativeName,
    required this.capital,
    required this.region,
    required this.flagUrl,
    required this.currencyName,
    required this.currencySymbol,
    required this.phoneCode,
    required this.area,
    required this.population,
    required this.lat,
    required this.lng,
  });

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) {
    final currencyEntry = (json['currencies'] as Map?)?.entries.firstOrNull;
    final currencyName = currencyEntry?.value['name'] ?? '';
    final currencySymbol = currencyEntry?.value['symbol'] ?? '';

    final root = json['idd']?['root'] ?? '';
    final suffix = (json['idd']?['suffixes'] as List?)?.firstOrNull ?? '';
    final phoneCode = '$root$suffix';

    final capital = (json['capital'] as List?)?.firstOrNull ?? 'N/A';

    final latlng = (json['latlng'] as List?) ?? [0.0, 0.0];
    final lat = latlng.isNotEmpty ? latlng[0].toDouble() : 0.0;
    final lng = latlng.length > 1 ? latlng[1].toDouble() : 0.0;

    return CountryResponseModel(
      name: json['name']?['common'] ?? 'Unknown',
      officialName: json['name']?['official'] ?? '',
      nativeName: json['name']?['nativeName']?['fra']?['common'],
      capital: capital,
      region: json['region'] ?? '',
      flagUrl: json['flags']?['png'] ?? '',
      currencyName: currencyName,
      currencySymbol: currencySymbol,
      phoneCode: phoneCode,
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      population: (json['population'] as num?)?.toInt() ?? 0,
      lat: lat,
      lng: lng,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'officialName': officialName,
      'nativeName': nativeName,
      'capital': capital,
      'region': region,
      'flagUrl': flagUrl,
      'currencyName': currencyName,
      'currencySymbol': currencySymbol,
      'phoneCode': phoneCode,
      'area': area,
      'population': population,
      'lat': lat,
      'lng': lng,
    };
  }
}
