import '../../core/models/CountryResponseModel.dart';
import '../../core/services/country_api_service.dart';



class CountryRepository {
  final CountryApiService api;

  CountryRepository(this.api);

  Future<List<CountryResponseModel>> getCountries() => api.fetchCountries();
}