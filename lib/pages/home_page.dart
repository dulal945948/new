import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business/const/const.dart';
import 'package:flutter_business/pages/details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, String? userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List category = ['Top item', 'Almirah', 'Alna', 'Chair', 'Table'];
  List category2 = ['top', 'almirah', 'alna', 'chair', 'table'];

  int selectedIndex = 0;
  List items = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getData('top');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage('assets/images/chair.jpg'),
              //     fit: BoxFit.cover)
              // shape: BoxShape.circle,
              // boxShadow: [
              //   BoxShadow(color: Colors.blue, spreadRadius: 40, blurRadius: 13),
              // ],
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
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Best Furniture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 103, 217),
                ),
              ),
              const Text(
                'Your Perfect choice !!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 134, 35, 109),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 45,
                width: 300,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'search here',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF6F7F8)),
                          borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF6F7F8)),
                          borderRadius: BorderRadius.circular(16)),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF6F7F8)),
                          borderRadius: BorderRadius.circular(16)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            getItemDataByQuery(toString());
                          },
                          icon: const Icon(Icons.search))),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MaterialButton(
                          highlightColor: Colors.green.shade200,
                          height: 30,
                          shape: const StadiumBorder(),
                          color: selectedIndex == index
                              ? Colors.deepPurpleAccent.shade200
                              : null,
                          onPressed: () {
                            selectedIndex = index;
                            items.clear();
                            getData(category2[selectedIndex]);
                            setState(() {});
                          },
                          minWidth: 10,
                          child: Text(category[index],
                              style: TextStyle(
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : const Color.fromARGB(255, 197, 233, 66),
                                  fontWeight: selectedIndex == index
                                      ? FontWeight.bold
                                      : null,
                                  fontSize: selectedIndex == index ? 20 : 18)));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 1,
                      );
                    },
                    itemCount: category.length),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                  fit: FlexFit.loose,
                  child: items.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                              productDetails: items[index],
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
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        margin: const EdgeInsets.all(16),
                                        child:
                                            // Image.asset(
                                            // 'assets/images/chair.jpg'),
                                            Image.network(
                                                items[index]['image']),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // 'category',
                                              items[index]['category'],
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Color.fromARGB(
                                                      255, 255, 103, 217),
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              //'title',
                                              items[index]['title'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 248, 179, 231),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              //'description',
                                              items[index]['description'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color.fromARGB(
                                                      255, 197, 233, 66),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              //'rating',
                                              '★★★☆ ${items[index]['rating']}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 197, 233, 66),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  // 'price',
                                                  '৳ ${items[index]['price']}',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                MaterialButton(
                                                  color:
                                                      const Color(0xff0B0B45),
                                                  shape: const StadiumBorder(),
                                                  child: const Text('Buy now',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                  onPressed: () {},
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
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemCount: category.length))
            ],
          ),
        ),
      ),
    );
  }

  void getData(String keyword) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var data = await fireStore.collection(keyword).get();
    for (var doc in data.docs) {
      setState(() {
        Map map = {
          'category': doc['category'],
          'description': doc['description'],
          'image': doc['image'],
          'price': doc['price'],
          'rating': doc['rating'],
          'title': doc['title'],
        };
        items.add(map);
      });
      if (kDebugMode) {
        print(items);
      }
    }
  }

  void getItemDataByQuery(String collectionName) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var data = await fireStore
        .collection(collectionName)
        .where('title', isEqualTo: searchController.text)
        .get();
    for (var doc in data.docs) {
      setState(() {
        Map map = {
          'category': doc['category'],
          'description': doc['description'],
          'image': doc['image'],
          'price': doc['price'],
          'rating': doc['rating'],
          'title': doc['title'],
        };
        items.add(map);
      });
      if (kDebugMode) {
        print(items);
      }
    }
  }
}
