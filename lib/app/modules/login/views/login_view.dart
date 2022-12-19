import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:mywistek/app/models/api.dart';
import 'package:mywistek/app/modules/home/views/home_view.dart';
import 'package:mywistek/app/modules/home/views/home_view_admin.dart';
import 'package:mywistek/app/routes/app_pages.dart';
import 'package:mywistek/utils/colors.dart';

import '../controllers/login_controller.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends GetView<LoginController> {
  // const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginMyWistek(),
    );
  }
}

class LoginMyWistek extends StatefulWidget {
  const LoginMyWistek({super.key});

  @override
  State<LoginMyWistek> createState() => _LoginMyWistekState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginMyWistekState extends State<LoginMyWistek> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  late String username, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      // print("$username, $password");
      login();
    }
  }

  login() async {
    // var url =
    //     Uri.http("192.168.1.2:1997", '/mywistek/login.php', {'q': '{http}'});
    final response = await http
        .post(Uri.parse('https://mywistek.wistek.id/login.php'), body: {
      'username': username,
      'password': password,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String usernameAPI = data['username'];
    String namaAPI = data['nama'];
    String id = data['id'];
    if (value == 1) {
      Fluttertoast.showToast(
        msg: 'Login Berhasil',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, usernameAPI, namaAPI, id);
      });
      print(pesan);
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username dan Password Invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
      print(pesan);
    }
  }

  savePref(int value, String username, String nama, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt('value', value);
      preferences.setString('nama', nama);
      preferences.setString('username', username);
      preferences.setString('id', id);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  // ignore: non_constant_identifier_names
  SignOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Form(
            key: _key,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
              children: [
                Image.asset(
                  "assets/images/login-img.png",
                  height: 300,
                  width: 300,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MY ",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "WISTEK",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: SizedBox(
                        height: 72,
                        width: 320,
                        //apply padding to all four sides
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Please insert username";
                            }
                          },
                          onSaved: (e) => username = e!,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.all(0),
                            hintText: "Nim",
                            prefixIcon: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                Icons.email,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                        height: 50,
                        width: 320, //apply padding to all four sides
                        child: TextFormField(
                          // validator: (e) {
                          //   if (e!.isEmpty) {
                          //     return "Please insert password";
                          //   }
                          // },
                          obscureText: _secureText,
                          onSaved: (e) => password = e!,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.all(0),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            prefixIcon: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                Icons.lock,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        height: 30,
                        width: 330,
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            print("Forgot Password");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          check();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text(
                          "MASUK",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomeView(SignOut);
        break;
    }
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.red, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}
