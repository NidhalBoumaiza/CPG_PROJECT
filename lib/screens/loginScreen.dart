import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../components/showCustom.dart';
import '../constants.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _EmailError = '';
  late String _PasswordError = '';
  late String email = '';
  late String password = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: KloginBackgroundDecoration,
            ),
            Center(
              child: Container(
                decoration: KMiddleContainerDecoration,
                height: 550,
                width: 320,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage("images/logo.jpg"),
                          height: 100,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 30, left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text('Email : '),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: KdecorationTextField.copyWith(
                                      hintText: "Enter your email address",
                                      errorText: _EmailError.isEmpty
                                          ? null
                                          : _EmailError,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text('Password : '),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      password = value;
                                    },
                                    decoration: KdecorationTextField.copyWith(
                                      hintText: "Enter your password",
                                      errorText: _PasswordError.isEmpty
                                          ? null
                                          : _PasswordError,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 50),
                                      child: Material(
                                        elevation: 5,
                                        color: Color(0xff5277B4),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (email.isEmpty ||
                                                  email == ' ') {
                                                _EmailError =
                                                    "Please provide your Email .";
                                              } else {
                                                _EmailError = '';
                                              }
                                              if (password.isEmpty ||
                                                  password == ' ') {
                                                _PasswordError =
                                                    "Please provide your Password .";
                                              } else {
                                                _PasswordError = '';
                                              }
                                            });
                                            print(email);
                                            print(password);
                                            var data = {
                                              "email": email,
                                              "password": password
                                            };
                                            var x = jsonEncode(data);
                                            print(x);
                                            try {
                                              final res = await http.post(
                                                  Uri.parse(
                                                      "$Kurl/api/v1/users/login"),
                                                  headers: {
                                                    'Content-Type':
                                                        'application/json; charset=UTF-8',
                                                  },
                                                  body: x);
                                              print(x);

                                              if (res.statusCode == 200) {
                                                Navigator.pushNamed(
                                                    context, '/homePage');
                                              } else {
                                                //showCustom(context, 'login');
                                                print(res.request);
                                              }
                                            } catch (err) {
                                              print(err);
                                            }
                                          },
                                          minWidth: 120,
                                          height: 50,
                                          child: Text(
                                            'LogIn',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text('or')),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Flexible(
                                    flex: 0,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: (() async {
                                          var data = {
                                            "email": email,
                                          };
                                          var x = jsonEncode(data);
                                          print(x);
                                          try {
                                            final res = await http.post(
                                                Uri.parse(
                                                    "$Kurl/api/v1/users/forgotpassword"),
                                                headers: {
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                },
                                                body: x);
                                            print(x);
                                            var decodedData =
                                                jsonDecode(res.body);
                                            print(decodedData);
                                          } catch (e) {
                                            print(e);
                                          }
                                        }),
                                        child: Container(
                                          child: Text(
                                            'Reset Password',
                                            style: KresetPasswordTextStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
