import 'package:flutter/foundation.dart';
import '../../core/models/CountryResponseModel.dart';
import '../data/country_repository.dart';

class CountryController extends ChangeNotifier {
  final CountryRepository repository;

  List<CountryResponseModel> countries = [];
  bool isLoading = true;
  String? error;

  CountryController(this.repository);

  Future<void> loadCountries() async {
    try {
      isLoading = true;
      notifyListeners();

      countries = await repository.getCountries();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
