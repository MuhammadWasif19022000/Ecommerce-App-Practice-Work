// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/screens/homepage.dart';
import 'package:ecommerce_practice/screens/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _intiliazation = Firebase.initializeApp();
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intiliazation,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error : ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot) {
              if (streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text("Error: ${streamsnapshot.error}")),
                );
              }

              if (streamsnapshot.connectionState == ConnectionState.active) {
                Object? _user = streamsnapshot.data;
                if (_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }

              return Scaffold(
                body: Center(
                    child: Text(
                  'Checking Authentication....',
                  style: Constants.regualrHeading,
                )),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
              child: Text(
            'Intiliazation App....',
            style: Constants.regualrHeading,
          )),
        );
      },
    );
  }
}
