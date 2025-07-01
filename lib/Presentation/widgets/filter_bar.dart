import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/filter_controller.dart';

class FilterBar extends StatelessWidget {
  final List<String> continents;
  final List<String> sortOptions;

  const FilterBar({
    super.key,
    required this.continents,
    required this.sortOptions,
  });

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Field
              TextField(
                onChanged: filter.updateSearch,
                decoration: InputDecoration(
                  hintText: 'Search country...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              //Continent + Sort Dropdowns
              Row(
                children: [
                  // Filter by Continent
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: filter.selectedContinent,
                      items: ['All', ...continents]
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => filter.updateContinent(val!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        labelText: '🌎 Continent',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Sort By
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: filter.sortBy,
                      items: sortOptions
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => filter.updateSortBy(val!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        labelText: '🔀 Sort',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
