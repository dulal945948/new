import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_business/sign%20in/login_page.dart';

// import 'auth/login_page.dart';
// import 'auth/login_page.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/chair.jpg'),
                  fit: BoxFit.cover)
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/images/chair.jpg'),
                  )),
              Text(
                'আর এফ এল ফার্নিচার',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 208, 0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
