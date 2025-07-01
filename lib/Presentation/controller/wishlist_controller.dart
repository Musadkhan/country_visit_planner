

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/models/CountryResponseModel.dart';

class WishlistController extends ChangeNotifier {
  final String _boxName = 'wishlist_box';
  List<CountryResponseModel> _wishlist = [];

  List<CountryResponseModel> get wishlist => _wishlist;

  WishlistController() {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final box = await Hive.openBox<CountryResponseModel>(_boxName);
    _wishlist = box.values.toList();
    notifyListeners();
  }

  Future<void> addToWishlist(CountryResponseModel country) async {
    final box = await Hive.openBox<CountryResponseModel>(_boxName);
    if (!_wishlist.any((c) => c.name == country.name)) {
      await box.put(country.name, country);
      _wishlist = box.values.toList();
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(CountryResponseModel country) async {
    final box = await Hive.openBox<CountryResponseModel>(_boxName);
    await box.delete(country.name);
    _wishlist = box.values.toList();
    notifyListeners();
  }

  bool isWishlisted(CountryResponseModel country) {
    return _wishlist.any((c) => c.name == country.name);
  }
}
