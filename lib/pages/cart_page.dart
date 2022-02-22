import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business/const/const.dart';
import 'package:flutter_business/pages/details_page.dart';

import '../const/user.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List cartListItems = [];
  int finalPrice = 0;
  @override
  void initState() {
    super.initState();
    getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: Colors.white,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 136, 10, 10),
          Color.fromARGB(255, 19, 179, 25),
          Color.fromARGB(255, 122, 114, 36),
          Color.fromARGB(255, 214, 140, 29),
          Color.fromARGB(255, 124, 26, 141),
          Color.fromARGB(255, 168, 32, 77),
          Color.fromARGB(255, 245, 66, 53),
          Color.fromARGB(255, 66, 92, 235),
          Color.fromARGB(255, 85, 229, 248),
          Color.fromARGB(255, 36, 253, 43),
          Color.fromARGB(255, 61, 3, 160)
        ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        child: cartListItems.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 'Your cart has 4',
                    'Your cart has ${cartListItems.length} items',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 134, 35, 109),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: cartListItems.length,
                    // itemCount: cartListItems.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        productDetails: cartListItems[index],
                                      )));
                        },
                        child: Container(
                            height: 190,
                            width: 450,
                            decoration: BoxDecoration(
                                color: cardBgColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  margin: const EdgeInsets.all(16),
                                  child:
                                      // Image.asset(
                                      // 'assets/images/chair.jpg'),
                                      Image.network(
                                          cartListItems[index]['image']),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // 'category',
                                        cartListItems[index]['category'],
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Color.fromARGB(
                                                255, 255, 103, 217),
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        //'title',
                                        cartListItems[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 248, 179, 231),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        //'description',
                                        cartListItems[index]['description'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromARGB(
                                                255, 197, 233, 66),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        //'rating',
                                        '★★★☆ ${cartListItems[index]['rating']}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 197, 233, 66),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            // 'price',
                                            '৳ ${cartListItems[index]['price']}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          MaterialButton(
                                            color: const Color(0xff0B0B45),
                                            shape: const StadiumBorder(),
                                            child: const Text('Remove',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                            onPressed: () {
                                              FirebaseFirestore firestore =
                                                  FirebaseFirestore.instance;
                                              firestore
                                                  .collection('users-cart')
                                                  .doc(cartListItems[index]
                                                      ['id'])
                                                  .delete();
                                              getCartData();
                                              finalPrice = 0;
                                              cartListItems.clear();
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '৳ 6000',
                          'Total: ${finalPrice.toString()} ৳',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MaterialButton(
                          color: const Color(0xff161E54),
                          shape: const StadiumBorder(),
                          onPressed: () => checkOut(),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void getCartData() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var data = await fireStore.collection('users-cart').get();
    for (var doc in data.docs) {
      setState(() {
        Map map = {
          'category': doc['category'],
          'description': doc['description'],
          'image': doc['image'],
          'price': doc['price'],
          'rating': doc['rating'],
          'title': doc['title'],
          'id': doc.id
        };
        cartListItems.add(map);
      });
      if (kDebugMode) {
        print(cartListItems);
      }
    }
    for (var item in cartListItems) {
      finalPrice = finalPrice + int.parse(item['price']);
      if (kDebugMode) {
        print(finalPrice);
      }
      setState(() {});
    }
  }
  

  checkOut() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users-cart')
        .doc(user_mail)
        .delete()
        .then((value) => print("User's Property Deleted"))
        .catchError(
            (error) => print("Failed to delete user's property: $error"));
    cartListItems.clear();
    setState(() {});
    print('object');
  }

  void removeItemFromCart(int index) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('users-cart')
        .doc(user_mail)
        .collection('cart')
        .doc(cartListItems[index]['doc-id'])
        .delete()
        .then((value) => print('item deleted'));

    cartListItems.clear();
    finalPrice = 0;
    getCartData();
  }
}
