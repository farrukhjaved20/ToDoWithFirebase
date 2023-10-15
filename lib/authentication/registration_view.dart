import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/constants/controllers.dart';
import 'package:firestore_app/authentication/login_view.dart';
import 'package:firestore_app/view/home_view.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({
    super.key,
  });

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  MyControllers controllers = MyControllers();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> signIn(BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controllers.emailcontroller.text.toString(),
        password: controllers.passwordcontroller.text.toString(),
      );
      users.add({
        'email': controllers.emailcontroller.text.toString(),
        'name': controllers.namecontroller.text.toString(),
        'website': controllers.websitecontroller.text.toString(),
        'phone Number': controllers.phonenumbercontroller.text.toString(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Welcome To Home Screen'),
        ),
      );
      // users.doc(credential.user!.uid).set({
      //   'id': credential.user!.uid,
      //   'Date': DateTime.now(),
      //   'email': controllers.emailcontroller.text.toString(),
      //   'name': controllers.namecontroller.text.toString(),
      //   'website': controllers.websitecontroller.text.toString(),
      //   'phone Number': controllers.phonenumbercontroller.text.toString(),
      // }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text('Welcome To Home Screen'),
      //       ),
      //     ));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formGlobalKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: 50, left: 10),
          child: const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Register Yourself!',
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
              const EdgeInsets.only(top: 120, bottom: 10, right: 10, left: 10),
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
                      children: [
                        const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg?size=626&ext=jpg'),
                            height: 300),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Name ';
                            }
                            return null;
                          },
                          controller: controllers.namecontroller,
                          decoration: InputDecoration(
                              labelText: 'Name',
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
                              return 'Enter Your Email Address ';
                            }
                            return null;
                          },
                          controller: controllers.emailcontroller,
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
                              return 'Enter Your Website ';
                            }
                            return null;
                          },
                          controller: controllers.websitecontroller,
                          decoration: InputDecoration(
                              labelText: 'Website',
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
                              return 'Enter Your Phone Number ';
                            }
                            return null;
                          },
                          controller: controllers.phonenumbercontroller,
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
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
                          controller: controllers.passwordcontroller,
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
                              "Have An Account ? ",
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
                                        builder: (context) => const LoginPage(),
                                      ));
                                },
                                child: const Text('Sign In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))),
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () {
                              if (formGlobalKey.currentState!.validate()) {
                                signIn(context);
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
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
