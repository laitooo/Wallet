import 'database.dart';
import 'models.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class NewRecordDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewRecordDialogState();
}

class NewRecordDialogState extends State<NewRecordDialog> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String name;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: dialogContent(),
    );
  }

  Widget dialogContent() {
    return Container(
      width: double.infinity,
      height: 200,
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "create a record",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: TextField(
                  autofocus: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                      border: OutlineInputBorder(),
                      labelText: "Record name"),
                  onChanged: (text) => {name = text},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      log("msg: " + name);
                      Record r = Record(7, name, 6, 2.05, 70.40, 68.35);
                      /*List<dynamic> data = [];
                      for(int i=0;i<1;i++){
                        data.add(r.toMap());
                      }
                      AppDatabase.insertRecord(data);*/

                      firestore
                          .collection('records')
                          .add(r.toMapWithUser(auth.currentUser.email));
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
