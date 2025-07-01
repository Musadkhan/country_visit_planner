
import 'package:flutter/material.dart';
import '../pages/visited_countries_tab.dart';
import '../pages/wishlist_countries_tab.dart';
import '../pages/all_countries_tab.dart';

class HomeController {
  int selectedIndex = 1;

  final List<Text> inactiveIconsList = const [
    Text("Wishlist",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black,fontSize: 16)),
    Text("All Countries",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black,fontSize: 16)),
    Text("Visited",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black,fontSize: 16)),
  ];
  final List<Icon> activeIcons = [
    Icon(Icons.favorite, color: Colors.deepPurple),
    Icon(Icons.public, color: Colors.deepPurple),
    Icon(Icons.check_circle, color: Colors.deepPurple),
  ];

  final List<Widget> tabs = const [
    WishlistTab(),
    AllCountriesTab(),
    VisitedCountriesTab(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
  }

}