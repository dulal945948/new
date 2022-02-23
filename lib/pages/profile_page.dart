import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business/const/user.dart';
import 'package:flutter_business/pages/store_page.dart';
import 'package:flutter_business/sign%20in/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var name, phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: user_name);
    phoneController = TextEditingController(text: user_phone);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          leading: BackButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const StorePage()));
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo,
                  Colors.deepOrange,
                  Colors.grey,
                  Colors.blue,
                  Colors.amber,
                  Colors.teal,
                  Colors.amber,
                ]),
            color: Colors.lightBlue,
            shape: BoxShape.rectangle,
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: const BorderRadius.only(
                // topLeft: Radius.circular(40), bottomRight: Radius.circular(60)
                ),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey.shade300,
                  blurRadius: 4.0,
                  spreadRadius: 10,
                  offset: const Offset(2, 2))
            ],
          ),
          // constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 134, 35, 109),
                child: Icon(Icons.person, size: 50),
                radius: 40,
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                color: Colors.green.shade500,
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.orange,
                          Colors.indigo,
                          Colors.deepOrange,
                          Colors.grey,
                          Colors.lightGreen,
                          Colors.amber,
                          Colors.teal,
                          Colors.pink,
                        ]),
                    color: Colors.lightBlue,
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: const BorderRadius.only(
                        // topLeft: Radius.circular(35),
                        // bottomRight: Radius.circular(45)
                        ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey.shade300,
                          blurRadius: 4.0,
                          spreadRadius: 10,
                          offset: const Offset(2, 2))
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        name ?? 'Null data',
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.green.shade500,
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.orange,
                          Colors.indigo,
                          Colors.deepOrange,
                          Colors.grey,
                          Colors.lightGreen,
                          Colors.amber,
                          Colors.teal,
                          Colors.pink,
                        ]),
                    color: Colors.lightBlue,
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: const BorderRadius.only(
                        // topLeft: Radius.circular(35),
                        // bottomRight: Radius.circular(45)
                        ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey.shade300,
                          blurRadius: 4.0,
                          spreadRadius: 10,
                          offset: const Offset(2, 2))
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const Icon(Icons.mail),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        user_mail ?? 'Null data',
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.green.shade500,
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.orange,
                          Colors.indigo,
                          Colors.deepOrange,
                          Colors.grey,
                          Colors.lightGreen,
                          Colors.amber,
                          Colors.teal,
                          Colors.pink,
                        ]),
                    color: Colors.lightBlue,
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: const BorderRadius.only(
                        // topLeft: Radius.circular(35),
                        // bottomRight: Radius.circular(45)
                        ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey.shade300,
                          blurRadius: 4.0,
                          spreadRadius: 10,
                          offset: const Offset(2, 2))
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        phone ?? 'Null data',
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      height: 40,
                      minWidth: 100,
                      color: Colors.blue.shade400,
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        'Log out',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                  MaterialButton(
                      height: 40,
                      minWidth: 100,
                      color: Colors.blue.shade400,
                      onPressed: () {
                        editProfile();
                      },
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              )
            ],
          ),
        ));
  }

  getUserData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var userData = await firestore.collection('user').doc(user_mail).get();

    user_mail = userData['mail'];
    name = userData['name'];
    phone = userData['phone'];
    setState(() {});
    if (kDebugMode) {
      print(user_mail);
    }
    if (kDebugMode) {
      print(userData);
    }
  }

  editProfile() {
    showDialog(
      barrierColor: Colors.amber.shade200,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Update your profile',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(icon: Icon(Icons.person)),
              ),
              TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(icon: Icon(Icons.phone))),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                updateProfile();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  updateProfile() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('user').doc(user_mail).update({
      'name': nameController.text,
      'phone': phoneController.text
    }).then((value) => getUserData());
  }
}
