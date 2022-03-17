import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mysqltestwebhost/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<void> registerUser() async {
    var url = "https://studentinternal.000webhostapp.com/signup.php";
    var data = {
      "email" : email.text,
      "name" : name.text,
      "pass" : pass.text,
    };
    var res = await http.post(Uri.parse(url),body: data);

    if(jsonDecode(res.body) == "account already existed"){
      Fluttertoast.showToast(msg: "Already Existed",toastLength: Toast.LENGTH_SHORT);
    }else{
      if(jsonDecode(res.body) == "true"){
        Fluttertoast.showToast(msg: "Created",toastLength: Toast.LENGTH_SHORT);
      }
    }

}

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50.0,),
          TextField(
            controller: email,
          ),
          const SizedBox(height: 50.0,),
          TextField(
            controller: name,
          ),
          const SizedBox(height: 50.0,),
          TextField(
            controller: pass,
          ),
          const SizedBox(height: 50.0,),
          InkWell(
            onTap: (){
              registerUser();
            },
            child: const SizedBox(
              height: 40.0,
              child: Center(
                child: Text(
                    "Sign Up",
                ),
              ),
            ),
          ),
          const SizedBox(height: 50.0,),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            child: const SizedBox(
              height: 40.0,
              child: Center(
                child: Text(
                  "Sign IN",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
