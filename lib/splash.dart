import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Wallet",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100.0,
                ),
                RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.blue,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    }),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.blue,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }),
              ]),
        ),
      ),
    );
  }
}
