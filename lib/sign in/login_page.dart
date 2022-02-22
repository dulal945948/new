import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business/sign%20in/sign_up_page.dart';
import 'package:flutter_business/pages/store_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Image.asset('assets/images/chair.jpg'),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/chair.jpg'), fit: BoxFit.cover)
            // shape: BoxShape.circle,
            // boxShadow: [
            //   BoxShadow(color: Colors.blue, spreadRadius: 40, blurRadius: 13),
            // ],
            // gradient: LinearGradient(colors: [
            //   Color.fromARGB(255, 136, 10, 10),
            //   Color.fromARGB(255, 19, 179, 25),
            //   Color.fromARGB(255, 122, 114, 36),
            //   Color.fromARGB(255, 214, 140, 29),
            //   Color.fromARGB(255, 124, 26, 141),
            //   Color.fromARGB(255, 168, 32, 77),
            //   Color.fromARGB(255, 245, 66, 53),
            //   Color.fromARGB(255, 66, 92, 235),
            //   Color.fromARGB(255, 85, 229, 248),
            //   Color.fromARGB(255, 36, 253, 43),
            //   Color.fromARGB(255, 61, 3, 160)
            // ], begin: Alignment.bottomRight, end: Alignment.topLeft)
            ),
        child: ListView(
            padding: const EdgeInsets.only(
                left: 12, right: 12, top: 100, bottom: 15),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    // height: 250,
                    // width: 450,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/chair.jpg'),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: mailController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      // icon: Icon(Icons.mail),
                      isDense: true,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 197, 233, 66),
                      prefixIcon: const Icon(Icons.mail),
                      suffixIcon: mailController.text.isEmpty
                          ? const Text('')
                          : GestureDetector(
                              onTap: () {
                                mailController.clear();
                              },
                              child: const Icon(Icons.close)),
                      hintText: 'example@mail.com',
                      // labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF6F7F8)),
                          borderRadius: BorderRadius.circular(16)),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffF6F7F8)),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: !isVisible,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 197, 233, 66),
                        isDense: true,
                        filled: true,
                        hintText: 'Your password',
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
                        suffixIcon: InkWell(
                            onTap: () {
                              isVisible = !isVisible;
                              setState(() {});
                            },
                            child: !isVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        prefixIcon: const Icon(Icons.lock)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                      minWidth: 150,
                      shape: const StadiumBorder(),
                      color: Colors.yellow.shade100,
                      child: const Text('Log in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color.fromARGB(255, 80, 75, 190))),
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StorePage()));
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: mailController.text,
                                  password: passwordController.text);
                          var user = userCredential.user;
                          if (user != null) {
                            if (kDebugMode) {
                              print(user.uid);
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            if (kDebugMode) {
                              print('No user found for that email.');
                            }
                          } else if (e.code == 'wrong-password') {
                            if (kDebugMode) {
                              print('Wrong password provided for that user.');
                            }
                          }
                        }
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 67, 83, 8)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text('Create account',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 55, 189, 252),
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis))),
                    ],
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
