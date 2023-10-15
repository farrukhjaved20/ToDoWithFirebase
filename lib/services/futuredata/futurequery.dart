// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/Utils/controller.dart';
import 'package:firestore_app/services/firebase.dart';
import 'package:flutter/material.dart';

class FutureQuery extends StatefulWidget {
  const FutureQuery({super.key});

  @override
  State<FutureQuery> createState() => _FutureQueryState();
}

class _FutureQueryState extends State<FutureQuery> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser;
  MyMethods methods = MyMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[300],
          title: const Text(
            'Future Query Builder',
            style: TextStyle(color: Colors.white),
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          user;
        },
        child: FutureBuilder<QuerySnapshot>(
          future: users.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            }

            //  final List document = snapshot.data!.docs;

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];

                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['website']),
                  trailing: Wrap(children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isUpdate = true;
                            titleid = data.id;
                          });

                          Mycontrollers.namecontroller.text = data['name'];
                          Mycontrollers.websitecontroller.text =
                              data['website'];
                          methods.bottomsheet(context);
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(data.id)
                              .delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 10),
                                  content:
                                      Text('User Deleted Using Future Query')));
                        },
                        icon: const Icon(Icons.delete_sharp))
                  ]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
