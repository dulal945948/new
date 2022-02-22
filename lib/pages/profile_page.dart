import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business/const/user.dart';
import 'package:flutter_business/sign%20in/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List userData = [];

  // String? user_name;
  // String? user_mail;
  // String? user_phone;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
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
      ),
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints.expand(),
      child:
          //  user_phone == null
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 197, 233, 66),
            radius: 60,
            child: Icon(
              Icons.person_outline,
              size: 80,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.person),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'user_name', style: TextStyle(fontSize: 18),
                    // userData[index]['name'],
                    // style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.mail),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'user_mail', style: TextStyle(fontSize: 18),
                    // userData[index]['email'],
                    // style: const TextStyle(fontSize: 18),
                    // userData[index]['email']
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.phone),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'user_phone', style: TextStyle(fontSize: 18), 

                    // userData[index]['phone'],
                    // style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  color: const Color.fromARGB(255, 197, 233, 66),
                  onPressed: () {},
                  // => editProfile(),
                  child: const Text('Edit Profile'),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  color: const Color.fromARGB(255, 197, 233, 66),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text('Log out'),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  editProfile() {
    TextEditingController nameController =
        TextEditingController(text: user_name);
    TextEditingController phoneController =
        TextEditingController(text: user_phone);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(icon: Icon(Icons.person_outline)),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(icon: Icon(Icons.phone)),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    firestore.collection('users').doc().update({
                      'name': nameController.text,
                      'phone': phoneController.text
                    });

                    getUserData();
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }

  void getUserData() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var data = await fireStore.collection('users').get();
    for (var doc in data.docs) {
      setState(() {
        Map map = {
          user_mail: doc['email'],
          user_name: doc['name'],
          user_phone: doc['phone'],
          user_id: doc.id
        };
        userData.add(map);
      });
      if (kDebugMode) {
        print(userData);
      }
    }
  }
}
