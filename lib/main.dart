import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';
import 'database.dart';
import 'models.dart';
import 'dialogs.dart';
import 'record_screen.dart';
import 'splash.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  AppDatabase.started = true;
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/list': (context) => MyList(),
        '/record': (context) => RecordDetail(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

class MyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyList();
}

class _MyList extends State<MyList> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  List<Record> records = [];

  _MyList() {
    //getCurrentUser();
    loadRecords(auth.currentUser.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wallet"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                auth.signOut();
                Navigator.pushNamed(context, '/login');
              })
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: records.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildItemsForListView(context, index, records[index]);
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return NewRecordDialog();
              },
            );
          }),
    );
  }

  Container _buildItemsForListView(
      BuildContext context, int index, Record record) {
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
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/record');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record.name,
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
                textBox("credit : \n" + record.credit.toString()),
                textBox("debit : \n" + record.debit.toString()),
                textBox("balance : \n" + record.balance.toString()),
              ],
            )
          ],
        ),
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

  void getCurrentUser() async {
    try {
      final user = await auth.currentUser;
      if (user != null) {
        print(user);
      }
    } catch (e) {
      print(e);
    }
  }

  loadRecords(String email) {
    try {
      List<Record> list = List();
      firestore.collection('records').get().then((snapshot) =>
      {
        for (var record in snapshot.docs)
          {
            if (record.data()['user'] == email)
              {print(record.data()),
                list.add(Record.fromMap(record.data())),
                }
          }
      });
      setState(() {
        records.addAll(list);
      });
    }catch(e){
      print(e);
    }
  }
}
