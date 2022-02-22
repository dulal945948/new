import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business/const/const.dart';
import 'package:flutter_business/const/user.dart';
import 'package:flutter_business/pages/details_page.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List wishListItems = [];
  @override
  void initState() {
    super.initState();
    getWishlistData();
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
        child: wishListItems.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Wishlist',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 103, 217)),
                  ),
                  const Text(
                    'Product that you loved!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 134, 35, 109),
                      // fontFamily: 'cormorant'
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: wishListItems.length,
                    // itemCount: wishListItems.length,
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
                                        productDetails: wishListItems[index],
                                      )));
                        },
                        child: Container(
                            height: 200,
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
                                          wishListItems[index]['image']),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // 'category',
                                            wishListItems[index]['category'],
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: Color.fromARGB(
                                                    255, 255, 103, 217),
                                                fontWeight: FontWeight.bold,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          CloseButton(
                                            onPressed: () {
                                              FirebaseFirestore firestore =
                                                  FirebaseFirestore.instance;
                                              firestore
                                                  .collection('wish-list')
                                                  .doc(wishListItems[index]
                                                      ['id'])
                                                  .delete();
                                              getWishlistData();
                                              wishListItems.clear();
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        //'title',
                                        wishListItems[index]['title'],
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
                                        wishListItems[index]['description'],
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
                                        '★★★☆ ${wishListItems[index]['rating']}',
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
                                            '৳ ${wishListItems[index]['price']}',
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
                                            child: const Text('Buy now',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                            onPressed: () {
                                              addToCart(index: index);
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
                ],
              ),
      ),
    );
  }

  void getWishlistData() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var data = await fireStore.collection('wish-list').get();
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
        wishListItems.add(map);
      });
      if (kDebugMode) {
        print(wishListItems);
      }
    }
  }

  void getCartData() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var data = await fireStore.collection('wish-list').get();
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
        wishListItems.add(map);
      });
      if (kDebugMode) {
        print(wishListItems);
      }
    }
  }

  void removeItemFromWishlist(int index) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('whish-list')
        .doc(user_mail)
        .collection('items')
        .doc(wishListItems[index]['doc-id'])
        .delete()
        // ignore: avoid_print
        .then((value) => print('item deleted'));
    wishListItems.clear();
    getWishlistData();
  }

  void addToCart({
    required int index,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users-cart')
        .doc(user_mail)
        .collection('cart')
        .add(wishListItems[index]);
    getWishlistData();

    showSuccessDialog('Successfully Added to Cart', context);
  }

  void showSuccessDialog(String msg, context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(msg),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
