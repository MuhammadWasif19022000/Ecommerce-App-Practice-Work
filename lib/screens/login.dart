// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/screens/homepage.dart';
import 'package:ecommerce_practice/screens/registerpage.dart';
import 'package:ecommerce_practice/widgets/customBtn.dart';
import 'package:ecommerce_practice/widgets/customBtn1.dart';
import 'package:ecommerce_practice/widgets/customfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }

  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    // ignore: no_leading_underscores_for_local_identifiers
    String? _createAccontFeedback = await _createAccount();
    if (_createAccontFeedback != null) {
      _alertDialogBuilder(_createAccontFeedback);
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  bool _registerFormLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";

  late FocusNode _passwordsFocusNode;
  @override
  void initState() {
    _passwordsFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Text(
                  'Welcome User,\nLogin to your Account',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CustomField(
                    isPasswordField: false,
                    hintText: 'Email...',
                    onchanged: (value) {
                      _registerEmail = value;
                    },
                    onsubmit: (value) {
                      _passwordsFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomField(
                    isPasswordField: true,
                    hintText: 'Password...',
                    onchanged: (value) {
                      _registerPassword = value;
                    },
                    onsubmit: (value) {
                      _submitForm();
                    },
                    focusNode: _passwordsFocusNode,
                  ),
                  CustomBtn1(
                    text: 'Login',
                    onPressed: () {
                      _submitForm();
                      // //_alertDialogBuilder();
                      // setState(() {
                      //   _registerFormLoading = true;
                      // });
                    },
                    isloading: _registerFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: CustomBtn(
                  text: "Create New Account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
