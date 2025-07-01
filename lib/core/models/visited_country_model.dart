
import 'package:hive/hive.dart';

part 'visited_country_model.g.dart';

@HiveType(typeId: 1)
class VisitedCountryModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String flagUrl;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final DateTime endDate;

  @HiveField(4)
  final String visitedPlaces;

  @HiveField(5)
  final double cost;

  @HiveField(6)
  final String currency;

  @HiveField(7)
  final int satisfactionScore;

  @HiveField(8)
  final String region;

  @HiveField(9)
  final int population;

  VisitedCountryModel({
    required this.name,
    required this.flagUrl,
    required this.startDate,
    required this.endDate,
    required this.visitedPlaces,
    required this.cost,
    required this.currency,
    required this.satisfactionScore,
    required this.region,
    required this.population
  });
}
