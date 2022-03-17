import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<void> loginUser() async {
    var url = "https://studentinternal.000webhostapp.com/signin.php";
    var data = {
      "email" : email.text,
      "pass" : pass.text,
    };
    var res = await http.post(Uri.parse(url),body: data);

    if(jsonDecode(res.body) == "true"){
      Fluttertoast.showToast(msg: "Logged in",toastLength: Toast.LENGTH_SHORT);
    }else{
      Fluttertoast.showToast(msg: "Failed",toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login using MYSQL'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50.0,),
            TextField(
              controller: email,
            ),
            const SizedBox(height: 50.0,),
            TextField(
              controller: pass,
            ),
            const SizedBox(height: 50.0,),
            InkWell(
              onTap: (){
                loginUser();
              },
              child: const SizedBox(
                height: 40.0,
                child: Center(
                  child: Text(
                    "Sign Up",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
