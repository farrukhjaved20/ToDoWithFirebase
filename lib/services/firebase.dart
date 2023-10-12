import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firestore_app/Utils/controller.dart';
import 'package:firestore_app/Utils/roundbutton.dart';

import 'package:flutter/material.dart';

bool isUpdate = false;

class MyMethods {
  final user = FirebaseAuth.instance.currentUser;
  adduser() async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': Mycontrollers.namecontroller.text,
      'website': Mycontrollers.websitecontroller.text,
    });

    Mycontrollers.namecontroller.clear();
    Mycontrollers.websitecontroller.clear();
  }

  updateuUserUnique({String? id}) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'name': Mycontrollers.namecontroller.text,
      'website': Mycontrollers.websitecontroller.text,
    });

    Mycontrollers.namecontroller.clear();
    Mycontrollers.websitecontroller.clear();
  }

  // String titleid = '';
  // updateuser() async {
  //   await FirebaseFirestore.instance.collection('users').doc(titleid).update({
  //     'name': Mycontrollers.namecontroller.text,
  //     'website': Mycontrollers.websitecontroller.text,
  //   });

  //   Mycontrollers.namecontroller.clear();
  //   Mycontrollers.websitecontroller.clear();
  // }

  bottomsheet(
    context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: Mycontrollers.namecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                TextField(
                  controller: Mycontrollers.websitecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.2,
                      child: RoundButton(
                        text: isUpdate ? 'Update' : 'Add',
                        onTap: () async {
                          if (isUpdate) {
                            await updateuUserUnique(id: user!.uid);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 10),
                              content: Text('User Updated'),
                            ));
                            Navigator.pop(context);
                          } else {
                            await adduser();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 10),
                              content: Text('User Added'),
                            ));

                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.01,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.2,
                      child: RoundButton(
                        text: 'Cancel',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
