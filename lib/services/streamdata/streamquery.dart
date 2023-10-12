import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/Utils/controller.dart';
import 'package:firestore_app/authentication/login_view.dart';
import 'package:firestore_app/services/firebase.dart';
import 'package:flutter/material.dart';

class StreamQuery extends StatefulWidget {
  const StreamQuery({super.key});

  @override
  State<StreamQuery> createState() => _StreamQueryState();
}

class _StreamQueryState extends State<StreamQuery> {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  MyMethods methods = MyMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[300],
          title: const Text(
            'Stream Query Builder',
            style: TextStyle(color: Colors.white),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //     final List data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return ListTile(
                title: Text(data['name'].toString()),
                subtitle: Text(data['website'].toString()),
                trailing: Wrap(children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isUpdate = true;
                          Mycontrollers.namecontroller.text = data['name'];
                          Mycontrollers.websitecontroller.text =
                              data['website'];
                        });
                       
                        methods.bottomsheet(context);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(data.id)
                            .delete();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 10),
                          content: Text('User Deleted Using Stream Query'),
                        ));
                       
                      },
                      icon: const Icon(Icons.delete))
                ]),
              );
            },
          );
        },
      ),
    );
  }
}
