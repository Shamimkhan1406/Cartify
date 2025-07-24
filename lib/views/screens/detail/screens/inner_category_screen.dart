import 'package:cartify/models/category.dart';
import 'package:cartify/views/screens/detail/screens/widgets/inner_category_content_widget.dart';
import 'package:cartify/views/screens/nav_screens/cart_screen.dart';
import 'package:cartify/views/screens/nav_screens/category_screen.dart';
import 'package:cartify/views/screens/nav_screens/favorites_screen.dart';
import 'package:cartify/views/screens/nav_screens/profile_screen.dart';
import 'package:cartify/views/screens/nav_screens/stores_screen.dart';
import 'package:flutter/material.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  // late Future<List<SubCategory>> _subCategories;
  // SubCategoryController _subcategoryController = SubCategoryController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _subCategories = _subcategoryController.getSubCategoryByCategoryName(widget.category.name);
  // }
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      InnerCategoryContentWidget(category: widget.category),
      FavoritesScreen(),
      CategoryScreen(),
      StoresScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(
      //     MediaQuery.of(context).size.height * 1.5,
      //   ),
      //   child: InnerHeaderWidget(),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
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
            icon: Icon(Icons.category_outlined),
            label: "Categories",
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
      body: pages[pageIndex],
    );
  }
}
