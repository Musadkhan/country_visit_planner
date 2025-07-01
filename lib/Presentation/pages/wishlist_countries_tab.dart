
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/CountryResponseModel.dart';
import '../../routing/app_router.dart';
import '../controller/filter_controller.dart';
import '../controller/wishlist_controller.dart';
import '../widgets/CountryCard.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterController>(context);
    final wishlist = Provider.of<WishlistController>(context);

    List<CountryResponseModel> filtered = wishlist.wishlist.where((country) {
      final matchesSearch = country.name.toLowerCase().contains(filter.searchQuery.toLowerCase());
      final matchesContinent = filter.selectedContinent == 'All' || country.region == filter.selectedContinent;
      return matchesSearch && matchesContinent;
    }).toList();

    if (filter.sortBy == 'Name') {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    } else if (filter.sortBy == 'Population') {
      filtered.sort((a, b) => b.population.compareTo(a.population));
    }

    return SafeArea(
      child: filtered.isEmpty
          ? const Center(child: Text('No wishlist countries'))
          : ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final c = filtered[index];
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
      ),
    );
  }


}
