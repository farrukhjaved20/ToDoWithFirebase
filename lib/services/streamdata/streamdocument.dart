import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/Utils/controller.dart';
import 'package:firestore_app/authentication/login_view.dart';
import 'package:firestore_app/services/firebase.dart';
import 'package:flutter/material.dart';

class StreamDocument extends StatefulWidget {
  const StreamDocument({super.key});

  @override
  State<StreamDocument> createState() => _StreamDocumentState();
}

class _StreamDocumentState extends State<StreamDocument> {
  final user = FirebaseAuth.instance.currentUser;
  late final Stream<DocumentSnapshot> stream =
      FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots();
  MyMethods methods = MyMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[300],
          title: const Text(
            'Stream Document Builder',
            style: TextStyle(color: Colors.white),
          )),
      body: StreamBuilder<DocumentSnapshot>(
        stream: stream,
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
                      Mycontrollers.namecontroller.text = data['name'];
                      Mycontrollers.websitecontroller.text = data['website'];
                    });

                    methods.bottomsheet(context);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    user!.delete();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 10),
                      content: Text('User Deleted Using Stream Document'),
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
