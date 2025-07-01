import 'package:country_visit_planner/Presentation/pages/visit_form_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/models/CountryResponseModel.dart';
import '../controller/wishlist_controller.dart';
import '../widgets/MiniMapWidget.dart';

class CountryDetailScreen extends StatefulWidget {
  final CountryResponseModel country;
  const CountryDetailScreen({super.key, required this.country});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showButtons = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final country = widget.country;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    country.flagUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(country.name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(country.officialName, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_city),
                            Expanded(
                              child: Text(
                                " Capital city ${country.capital}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(child: _infoCard("${country.population}", "Population", Colors.green)),
                            const SizedBox(width: 12),
                            Expanded(child: _infoCard("${country.area}", "Area", Colors.orange)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _infoDetailCard(country),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 20,
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Map", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 15),
                                MiniMapWidget(latitude: country.lat, longitude: country.lng),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Floating buttons with animation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset: _showButtons ? Offset.zero : const Offset(0, 1),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: _showButtons ? 1 : 0,
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<WishlistController>(
                        builder: (context, wishlistCtrl, _) {
                          final isSaved = wishlistCtrl.isWishlisted(country);
                          return ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: isSaved ? Colors.redAccent : Colors.blueAccent,
                            ),
                            icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border),
                            label: Text(isSaved ? "Remove from Wishlist" : "Add to Wishlist"),
                            onPressed: () {
                              if (isSaved) {
                                wishlistCtrl.removeFromWishlist(country);
                              } else {
                                wishlistCtrl.addToWishlist(country);
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.green,
                        ),
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text("Mark as Visited"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VisitFormPage(
                                countryName: country.name,
                                flagUrl: country.flagUrl,
                                region: country.region,
                                population: country.population,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String value, String label, Color color) {
    return Card(
      elevation: 20,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _infoDetailCard(CountryResponseModel country) {
    return Card(
      elevation: 20,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInfoDetail(const Icon(Icons.public, color: Colors.lightBlueAccent), "Region", country.region),
            _buildInfoDetail(const Icon(Icons.people, color: Colors.purpleAccent), "Phone code", country.phoneCode),
            _buildInfoDetail(const Icon(Icons.money, color: Colors.greenAccent), "Currencies", "${country.currencyName} ${country.currencySymbol}"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoDetail(Icon icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: "$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
