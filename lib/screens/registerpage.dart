// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:ecommerce_practice/screens/login.dart';
import 'package:ecommerce_practice/widgets/customBtn1.dart';
import 'package:ecommerce_practice/widgets/customfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/customBtn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  bool _registerFormLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";

  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
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
                  'Create A New Accout',
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
                      _passwordFocusNode.requestFocus();
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
                    focusNode: _passwordFocusNode,
                  ),
                  CustomBtn1(
                    text: 'Register',
                    onPressed: () {
                      _submitForm(); // setState(() {
                      //   _registerFormLoading = true;
                      //   // _alertDialogBuilder();
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
                  text: "Back To Login",
                  onPressed: () {
                    Navigator.pop(context);
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
