import 'package:flutter/material.dart';
import 'package:Wallet/models.dart';
import 'package:Wallet/models.dart';

import 'package:Wallet/database.dart';

class RecordDetail extends StatefulWidget{

  @override
  State createState() {
    return _RecordDetail();
  }
}

class _RecordDetail extends State<RecordDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record name"),
      ),
      body: FutureBuilder(
        //future: loadRecords(),
        builder: (context, snapshot) {
          List<Record> list = snapshot.data ?? [];
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildItemsForListView(context, index, list[index]);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            /*showDialog(
              context: context,
              builder: (BuildContext context) {
                return NewRecordDialog();
              },
            );*/
          }),
    );
  }

  Widget _buildItemsForListView(BuildContext context, int index, Record list) {
    return Text("test");
  }
}