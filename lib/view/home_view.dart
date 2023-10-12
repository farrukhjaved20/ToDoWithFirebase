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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  MyMethods methods = MyMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundButton(
            text: 'Stream Query',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StreamQuery(),
                  ));
            },
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          RoundButton(
            text: 'Future Query',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FutureQuery(),
                  ));
            },
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          RoundButton(
            text: 'Stream Document',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StreamDocument(),
                  ));
            },
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          RoundButton(
            text: 'Future Document',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FutureDocument(),
                  ));
            },
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          FloatingActionButton(
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
          )
        ],
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firestore_app/authentication/login_view.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   FirebaseAuth.instance
//                       .signOut()
//                       .then((value) => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginPage(),
//                           )));
//                 },
//                 icon: const Icon(
//                   Icons.exit_to_app,
//                   color: Colors.white,
//                 ))
//           ],
//           backgroundColor: Colors.amber[700],
//           automaticallyImplyLeading: false,
//           title: const Text(
//             'Home Screen',
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//         ),
//         body: FutureBuilder<QuerySnapshot>(
//           future: users.get(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Text("Loading");
//             }

//             return ListView(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;
//                 return ListTile(
//                   title: Text(data['name'].toString()),
//                   subtitle: Text(data['id'].toString()),
//                   trailing: Text(data['phone Number'].toString()),
//                 );
//               }).toList(),
//             );
//           },
//         ));
//   }
// }
