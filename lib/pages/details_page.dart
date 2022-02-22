import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_business/pages/store_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.productDetails}) : super(key: key);

  final Map productDetails;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int quantity = 1;
  late TextEditingController quantityController;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    quantityController = TextEditingController(text: quantity.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StorePage()));
                      },
                      child: const Text(
                        '←',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )),
                  IconButton(
                      onPressed: () {
                        isSelected = true;
                        showMessage(msg: "Successfully added to WishList");
                        addToWishList();
                        setState(() {});
                      },
                      icon: Icon(
                          isSelected ? Icons.favorite : Icons.favorite_border))
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Image.network(
                  widget.productDetails['image'],
                  height: 140,
                  width: 450,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 0),
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
                      ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category: ${widget.productDetails['category']}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 103, 217),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: null,
                            child: Text(
                              '★★★☆   ${widget.productDetails['rating']}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 197, 233, 66),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Title: ${widget.productDetails['title']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 248, 179, 231),
                            ),
                          )),
                      Expanded(
                        child: Text(
                          'Description: ${widget.productDetails['description']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 197, 233, 66),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Quantity: ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 197, 233, 66),
                            ),
                          ),
                          MaterialButton(
                            color: const Color(0xff0B0B45),
                            shape: const StadiumBorder(),
                            onPressed: () {
                              if (quantity > 1) quantity--;
                              setState(() {});
                              if (kDebugMode) {
                                print(quantity);
                              }
                            },
                            child: const Text(
                              '-',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                quantity = int.parse(value);
                                setState(() {});
                              },
                              controller: quantityController,
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffF6F7F8)),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          MaterialButton(
                            color: const Color(0xff0B0B45),
                            shape: const StadiumBorder(),
                            onPressed: () {
                              quantity++;
                              setState(() {});
                            },
                            child: const Text(
                              '+',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "৳ ${int.parse(widget.productDetails['price']) * quantity}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          MaterialButton(
                            shape: const StadiumBorder(),
                            onPressed: () {
                              addToCart();
                              showMessage(msg: 'Succesfully added to cart');
                            },
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xff0B0B45),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addToCart() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('users-cart').add({
      'category': widget.productDetails['category'],
      'description': widget.productDetails['description'],
      'image': widget.productDetails['image'],
      'price': widget.productDetails['price'],
      'rating': widget.productDetails['rating'],
      'title': widget.productDetails['title'],
    });
  }

  void addToWishList() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('wish-list').add({
      'category': widget.productDetails['category'],
      'description': widget.productDetails['description'],
      'image': widget.productDetails['image'],
      'price': widget.productDetails['price'],
      'rating': widget.productDetails['rating'],
      'title': widget.productDetails['title'],
    });
  }

  showMessage({required String msg}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('worning!!'.toUpperCase()),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok'))
            ],
          );
        });
  }
}
