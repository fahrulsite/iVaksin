import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interma/adminView/adminChooser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewUser/appBarTitle.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

bool isLoading = false;
bool isFailed = false;

class _AdminLoginState extends State<AdminLogin> {
  String pesan = "";
  bool status = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();


  login() async {

    setState(() {
      isLoading = true;
    });
    String md5Pass =  md5.convert(utf8.encode(_password.text)).toString();
    var response = await http.post(Uri.parse("https://ivaksin.herokuapp.com/login"),
        body: {
          'username' :_username.text,
          'password': md5Pass,
        });
    print(response.body);

    var data = await json.decode(response.body);
    print('tes');
    bool status = data['status'];
    setState(() {
      pesan = data['message'];
    });

    if (status == true) {
      Get.to(AdminChooser());
      setState(() {
        isLoading = false;
        savePref(status);
      });
    } else {
      setState(() {
        isFailed = true;
        isLoading = false;
      });
      print(pesan);
    }
  }

  savePref(bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("status", status);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarTitle(
        nama: "Login Admin",
        preferredSize: Size.fromHeight(140),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: _username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Username",
                    labelText: "Masukkan Username"
                ),
              ) ,
            ),

            Container(
              margin: EdgeInsets.only(left: 16, right: 16,),
              child: TextField(
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    labelText: "Masukkan Password"
                ),
              ) ,
            ),

            InkWell(
              onTap: ()=>login(),
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xff61D2C4),
                ),
                height: 60,
                child: Center(
                  child: (isLoading)? CircularProgressIndicator() : Text(
                    "LOGIN", style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ),
              ),
            ),
            Center(
              child: (isFailed) ? Text(pesan, style: TextStyle(color: Colors.black),) : Text(""),
            )
          ],
        ),
      ),
    );
  }
}
