import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/visited_country_model.dart';
import '../controller/visited_controller.dart';
import '../controller/filter_controller.dart';

class VisitedCountriesTab extends StatelessWidget {
  const VisitedCountriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<VisitedController, FilterController>(
      builder: (context, visitedController, filter, _) {
        List<VisitedCountryModel> visits = visitedController.visitedList;

        //  Filter by search + continent
        visits = visits.where((visit) {
          final matchesSearch = visit.name.toLowerCase().contains(filter.searchQuery.toLowerCase());
          final matchesContinent = filter.selectedContinent == 'All' || visit.region == filter.selectedContinent;
          return matchesSearch && matchesContinent;
        }).toList();

        //  Sort
        if (filter.sortBy == 'Name') {
          visits.sort((a, b) => a.name.compareTo(b.name));
        } else if (filter.sortBy == 'Population') {
          visits.sort((a, b) => b.population.compareTo(a.population));
        }

        if (visits.isEmpty) {
          return const Center(child: Text('No visited countries match the filter.'));
        }

        // Group by region (continent)
        final groupedVisits = <String, List<VisitedCountryModel>>{};

        for (var visit in visits) {
          groupedVisits.putIfAbsent(visit.region, () => []).add(visit);
        }

        return ListView(
          children: groupedVisits.entries.map((entry) {
            final continent = entry.key;
            final countries = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    continent,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ...countries.map((visit) {
                  return Card(
                    elevation: 20,
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(visit.flagUrl),
                        ),
                        title: Text(
                          visit.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${_formatDate(visit.startDate)} → ${_formatDate(visit.endDate)}\n'
                              'Satisfaction: ${visit.satisfactionScore}/5',
                        ),
                        isThreeLine: true,
                        onTap: () => showVisitDetailDialog(context, visit),
                      ),
                    ),
                  );
                }),
              ],
            );
          }).toList(),
        );
      },
    );
  }


  void showVisitDetailDialog(BuildContext context, VisitedCountryModel visit) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Row
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(visit.flagUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      visit.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Divider(),

              // Details
              _buildStyledDetailRow('Visit Dates', '${_formatDate(visit.startDate)} → ${_formatDate(visit.endDate)}'),
              _buildStyledDetailRow('Visited Places', visit.visitedPlaces),
              _buildStyledDetailRow('Total Cost', '${visit.currency} ${visit.cost.toStringAsFixed(2)}'),
              _buildStyledDetailRow('Satisfaction', '${visit.satisfactionScore}/5'),

              const Divider(),

              // Close Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Close'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildStyledDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }


  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
