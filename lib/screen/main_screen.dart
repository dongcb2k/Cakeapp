import 'package:flutter/material.dart';

import 'cart/cart_screen.dart';
import 'detail/details_screen.dart';
import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final pages = [
    const HomeScreen(),
    const CartScreen(listCart: ['1', '2', '3', '4'],),
    const DetailsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: const Color(0xffd17842),
      unselectedItemColor: const Color(0xff4d4f52),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
