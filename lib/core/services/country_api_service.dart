
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_visit_planner/core/models/CountryResponseModel.dart';

class CountryApiService {
  final String _baseUrl = 'https://restcountries.com/v3.1/all?fields=name,flags,capital,region,population,idd,latlng,currencies,area';

  Future<List<CountryResponseModel>> fetchCountries() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List).map((e) => CountryResponseModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}