// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/Utils/controller.dart';
import 'package:firestore_app/Utils/roundbutton.dart';
import 'package:firestore_app/authentication/login_view.dart';
import 'package:firestore_app/services/firebase.dart';
import 'package:firestore_app/services/futuredata/futuredocment.dart';
import 'package:firestore_app/services/futuredata/futurequery.dart';
import 'package:firestore_app/services/streamdata/streamdocument.dart';
import 'package:firestore_app/services/streamdata/streamquery.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  MyMethods methods = MyMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white,
        tooltip: 'Add To Firebase Button',
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            isUpdate = false;
          });
          methods.bottomsheet(context);
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    )));
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.blue[300],
        automaticallyImplyLeading: false,
        title: const Text(
          'Firebase Crud App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // final List data = snapshot.data!.docs;

          return Column(
            children: [
              Lottie.network(
                'https://lottie.host/6d7a35f0-720e-48aa-a5c8-871d86ae2100/f1g0l6590w.json',
                animate: true,
                alignment: Alignment.center,
                fit: BoxFit.contain,
                repeat: true,
                height: MediaQuery.sizeOf(context).height * 0.3,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        tileColor: Colors.blue[300],
                        title: Text(
                          'Name: ' "${data['name'].toString()}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Website: ' "${data['website'].toString()}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: Wrap(children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isUpdate = true;
                                  titleid = data.id;
                                });
                                Mycontrollers.namecontroller.text =
                                    data['name'];
                                Mycontrollers.websitecontroller.text =
                                    data['website'];
                                methods.bottomsheet(context);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.amber,
                                size: 24,
                              )),
                          IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(data.id)
                                    .delete();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 10),
                                  content:
                                      Text('Data Deleted Using Stream Query'),
                                ));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.amber,
                                size: 24,
                              ))
                        ]),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
