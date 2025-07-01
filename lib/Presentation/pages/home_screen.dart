import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';


import '../widgets/filter_bar.dart';
import '../controller/filter_controller.dart';
import '../controller/home_controller.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();

  final List<String> continents = ['Asia', 'Europe', 'Africa', 'Oceania', 'Americas', 'Antarctic'];
  final List<String> sortOptions = ['Name', 'Population'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🌍 Global Filter Bar (applies to all tabs)
            FilterBar(
              continents: continents,
              sortOptions: sortOptions,
            ),

            // Tabs (All / Wishlist / Visited)
            Expanded(
              child: _controller.tabs[_controller.selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIndex: _controller.selectedIndex,
        onTap: (index) {
          setState(() {
            _controller.onItemTapped(index);
          });
        },
        activeIcons: _controller.activeIcons,
        inactiveIcons: _controller.inactiveIconsList,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        circleShadowColor: Colors.deepPurple,
        shadowColor: Colors.green,
        elevation: 20,
        color: Colors.white,
        circleGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
        ),
        circleColor: Colors.white,
        height: 60,
        circleWidth: 60,
      ),
    );
  }
}
