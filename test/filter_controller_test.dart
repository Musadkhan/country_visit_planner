import 'package:country_visit_planner/Presentation/controller/filter_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FilterController filterController;

  setUp(() {
    filterController = FilterController();
  });

  test('Search query updates correctly', () {
    filterController.updateSearch('india');
    expect(filterController.searchQuery, 'india');
  });

  test('Selected continent updates correctly', () {
    filterController.updateContinent('Asia');
    expect(filterController.selectedContinent, 'Asia');
  });

  test('Sort by updates correctly', () {
    filterController.updateSortBy('Name');
    expect(filterController.sortBy, 'Name');
  });
}
