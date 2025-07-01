import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../../../core/models/visited_country_model.dart';

class VisitedController extends ChangeNotifier {
  final String _boxName = 'visited_box';
  List<VisitedCountryModel> _visited = [];

  List<VisitedCountryModel> get visitedList => _visited;

  VisitedController() {
    _loadVisited();
  }

  Future<void> _loadVisited() async {
    final box = await Hive.openBox<VisitedCountryModel>(_boxName);
    _visited = box.values.toList();
    notifyListeners();
  }

  Future<void> addVisit(VisitedCountryModel visit) async {
    final box = await Hive.openBox<VisitedCountryModel>(_boxName);
    await box.add(visit);
    _visited = box.values.toList();
    notifyListeners();
  }

  Map<String, List<VisitedCountryModel>> groupByRegion() {
    final grouped = <String, List<VisitedCountryModel>>{};

    for (final country in visitedList) {
      final region = country.region ?? 'Unknown';
      grouped.putIfAbsent(region, () => []).add(country);
    }

    return grouped;
  }
}
