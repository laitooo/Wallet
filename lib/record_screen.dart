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
        future: loadTransactions(),
        builder: (context, snapshot) {
          List<Transaction> list = snapshot.data ?? [];
          list.add(Transaction(3, "From mostaql", "2020/11/09", 24.0, 0));
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

  Container _buildItemsForListView(
      BuildContext context, int index, Transaction transaction) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.title,
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textBox("credit : \n" + transaction.credit.toString()),
              textBox("debit : \n" + transaction.debit.toString()),
              textBox("date : \n" + transaction.date.toString()),
            ],
          )
        ],
      ),
    );
  }

  Widget textBox(String text) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      width: 110.0,
      height: 80.0,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontSize: 24.0, height: 1.4),
        ),
      ),
    );
  }

}

loadTransactions() {
  return null;
}