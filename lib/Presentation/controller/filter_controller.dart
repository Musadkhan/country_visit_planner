

import 'package:flutter/material.dart';

class FilterController extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedContinent = 'All';
  String _sortBy = 'Name';

  String get searchQuery => _searchQuery;
  String get selectedContinent => _selectedContinent;
  String get sortBy => _sortBy;

  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void updateContinent(String value) {
    _selectedContinent = value;
    notifyListeners();
  }

  void updateSortBy(String value) {
    _sortBy = value;
    notifyListeners();
  }
}
