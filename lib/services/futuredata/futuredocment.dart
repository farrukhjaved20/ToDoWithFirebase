import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/Utils/controller.dart';
import 'package:firestore_app/authentication/login_view.dart';
import 'package:firestore_app/services/firebase.dart';
import 'package:flutter/material.dart';

class FutureDocument extends StatefulWidget {
  const FutureDocument({super.key});

  @override
  State<FutureDocument> createState() => _FutureDocumentState();
}

class _FutureDocumentState extends State<FutureDocument> {
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
            'Query Document Builder',
            style: TextStyle(color: Colors.white),
          )),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['name'].toString()),
            subtitle: Text(data['website'].toString()),
            trailing: Wrap(children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isUpdate = true;
                    });
                    Mycontrollers.namecontroller.text = data['name'];
                    Mycontrollers.websitecontroller.text = data['website'];
                    methods.bottomsheet(context);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    user!.delete();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 10),
                      content: Text('User Deleted Using Future Document'),
                    ));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  icon: const Icon(Icons.delete))
            ]),
          );
        },
      ),
    );
  }
}
