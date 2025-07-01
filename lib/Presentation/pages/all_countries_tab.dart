import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/CountryResponseModel.dart';
import '../../routing/app_router.dart';
import '../controller/country_controller.dart';
import '../controller/filter_controller.dart';
import '../widgets/CountryCard.dart';

class AllCountriesTab extends StatelessWidget {
  const AllCountriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final countryController = Provider.of<CountryController>(context);
    final filter = Provider.of<FilterController>(context);

    if (countryController.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (countryController.error != null) {
      return Center(child: Text('Error: ${countryController.error}'));
    }

    // Apply Filter, Search
    List<CountryResponseModel> filteredCountries = countryController.countries.where((country) {
      final matchesSearch = country.name.toLowerCase().contains(filter.searchQuery.toLowerCase());
      final matchesContinent = filter.selectedContinent == 'All' || country.region == filter.selectedContinent;
      return matchesSearch && matchesContinent;
    }).toList();

    //  Apply Sort
    if (filter.sortBy == 'Name') {
      filteredCountries.sort((a, b) => a.name.compareTo(b.name));
    } else if (filter.sortBy == 'Population') {
      filteredCountries.sort((a, b) => b.population.compareTo(a.population));
    }

    return ListView.builder(
      itemCount: filteredCountries.length,
      itemBuilder: (context, index) {
        final c = filteredCountries[index];
        return CountryCard(
          country: c,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.detailCountry,
              arguments: c,
            );
          },
        );
      },
    );
  }
}
