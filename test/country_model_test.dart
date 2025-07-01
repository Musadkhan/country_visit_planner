
import 'package:country_visit_planner/core/models/CountryResponseModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CountryResponseModel fromJson parses correctly', () {
    final json = {
      "name": {"common": "India", "official": "Republic of India", "nativeName": {"hin": {"official": "Republic of india"}}},
      "capital": ["New Delhi"],
      "region": "Asia",
      "flags": {"png": "https://flagcdn.com/in.png"},
      "currencies": {"INR": {"name": "Indian rupee", "symbol": "₹"}},
      "idd": {"root": "+9", "suffixes": ["1"]},
      "population": 1380000000,
      "area": 3287263.0,
      "latlng": [20.0, 77.0],
    };

    final country = CountryResponseModel.fromJson(json);

    expect(country.name, "India");
    expect(country.officialName, "Republic of India");
    expect(country.capital, "New Delhi");
    expect(country.region, "Asia");
    expect(country.flagUrl, contains("in.png"));
    expect(country.currencyName, "Indian rupee");
    expect(country.currencySymbol, "₹");
    expect(country.phoneCode, "+91");
    expect(country.population, 1380000000);
    expect(country.area, 3287263.0);
    expect(country.lat, 20.0);
    expect(country.lng, 77.0);
  });
}
