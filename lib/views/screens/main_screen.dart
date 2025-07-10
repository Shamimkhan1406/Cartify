import 'package:cartify/views/screens/nav_screens/cart_screen.dart';
import 'package:cartify/views/screens/nav_screens/favorites_screen.dart';
import 'package:cartify/views/screens/nav_screens/home_screen.dart';
import 'package:cartify/views/screens/nav_screens/profile_screen.dart';
import 'package:cartify/views/screens/nav_screens/stores_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //const MainScreen({super.key});
  int _pageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoritesScreen(),
    StoresScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png",width: 25,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/love.png",width: 25,),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/mart.png",width: 25,),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/cart.png",width: 25,),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/user.png",width: 25,),
            label: "Account",
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
