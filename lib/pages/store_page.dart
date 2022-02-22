import 'package:flutter/material.dart';
import 'package:flutter_business/pages/cart_page.dart';
import 'package:flutter_business/pages/home_page.dart';
import 'package:flutter_business/pages/wishlist_page.dart';
import 'package:flutter_business/pages/profile_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List pages = [
    const HomePage(),
    const WishListPage(),
    const CartPage(
    
    ),
    const ProfilePage(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: MaterialButton(
      //       onPressed: () {
      //         Navigator.pushReplacement(context,
      //             MaterialPageRoute(builder: (context) => const LoginPage()));
      //       },
      //       child: conzst Icon(Icons.arrow_back_sharp)),
      // ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
