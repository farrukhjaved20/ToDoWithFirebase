// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/constants/controllers.dart';
import 'package:firestore_app/authentication/registration_view.dart';
import 'package:firestore_app/view/home_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MyControllers mycontrollers = MyControllers();
  Future<void> signin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mycontrollers.emailcontroller.text.toString(),
          password: mycontrollers.passwordcontroller.text.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Welcome Back'),
        ),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MyControllers controllers = MyControllers();
    final formGlobalKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: 50, left: 10),
          child: const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Hello\nSign in!',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 150, bottom: 10, right: 10, left: 10),
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: SingleChildScrollView(
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-vector/bank-login-concept-illustration_114360-7964.jpg?t=st=1696370189~exp=1696370789~hmac=896323d44e08390df1734b560a8ce66448f7a1ed38017dbf1adf60d18f3c9aa5'),
                            // 'https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg?size=626&ext=jpg'),
                            height: 350),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Email Address ';
                            }
                            return null;
                          },
                          controller: mycontrollers.emailcontroller,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password Upto 6 Characters ';
                            }
                            return null;
                          },
                          controller: mycontrollers.passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Don't Have An Account ? ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.amber)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Registration(),
                                      ));
                                },
                                child: const Text('Sign Up',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))),
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () {
                              if (formGlobalKey.currentState!.validate()) {
                                signin();
                              }
                            },
                            child: const Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ]),
    );
  }
}
