import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_business/const/user.dart';
import 'package:flutter_business/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Expanded(
              child: SizedBox(
                // height: 250,
                // width: 450,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/chair.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                    borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                    borderRadius: BorderRadius.circular(16)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: nameController,
              onChanged: (value) {
                setState(() {});
              }, 
              decoration: InputDecoration(
                // icon: Icon(Icons.mail),
                isDense: true,
                filled: true,
                fillColor: const Color.fromARGB(255, 197, 233, 66),
                prefixIcon: const Icon(Icons.account_box_sharp),
                suffixIcon: nameController.text.isEmpty
                    ? const Text('')
                    : GestureDetector(
                        onTap: () {
                          nameController.clear();
                        },
                        child: const Icon(Icons.close)),
                hintText: 'Your full name',
                // labelText: 'Email',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                    borderRadius: BorderRadius.circular(16)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: phoneController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                // icon: Icon(Icons.mail),
                isDense: true,
                filled: true,
                fillColor: const Color.fromARGB(255, 197, 233, 66),
                prefixIcon: const Icon(Icons.add_box),
                suffixIcon: phoneController.text.isEmpty
                    ? const Text('')
                    : GestureDetector(
                        onTap: () {
                          phoneController.clear();
                        },
                        child: const Icon(Icons.close)),
                hintText: 'Phone Number',
                // labelText: 'Email',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                    borderRadius: BorderRadius.circular(16)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffF6F7F8)),
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
                      borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                      borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffF6F7F8)),
                      borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffF6F7F8)),
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
              shape: const StadiumBorder(),
              color: Colors.yellow.shade100,
              onPressed: () async {
                userRegistration();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 80, 75, 190)),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Have you an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Login here')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> userRegistration() async {
    if (mailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: mailController.text, password: passwordController.text);
        var user = userCredential.user;
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        var userData = {
          'email': mailController.text,
          'name': nameController.text,
          'phone': phoneController.text,
        };
        await firestore.collection('users').doc(user?.email).set(userData);
        mailController.clear();
        nameController.clear();
        phoneController.clear();
        passwordController.clear();
        user_mail = user?.email;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(
                    // userId: user?.uid,
                    )));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showWarnigDialog(warning: 'The password provided is too weak.');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showWarnigDialog(
              warning: 'The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        if (kDebugMode) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    } else {
      showWarnigDialog(warning: 'Please fill all the field');
    }
  }

  void showWarnigDialog({required String warning}) {
    showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            title: const Text(
              'WARNING!',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(warning),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
