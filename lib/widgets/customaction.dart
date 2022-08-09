import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/screens/cartpage.dart';
import 'package:ecommerce_practice/servcies/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool hasArrowBack;
  final bool hasTitle;
  final bool? hasbackground;
  CustomActionBar(
      {Key? key,
      this.title,
      required this.hasArrowBack,
      required this.hasTitle,
      this.hasbackground})
      : super(key: key);
  FireabseServices _firebaseServices = FireabseServices();

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("Users");

//  User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    bool _hasArrowback = hasArrowBack ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasbackground = hasTitle ?? true;
    return Container(
      decoration: BoxDecoration(
        gradient: _hasbackground
            ? LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withAlpha(0),
                ],
                begin: Alignment(0, 0),
                end: Alignment(0, 1),
              )
            : null,
      ),
      padding: EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 42,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasArrowback)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Icon(
                    size: 18,
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _userRef
                    .doc(_firebaseServices.getUserId())
                    .collection('Cart')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  int _totaitems = 0;
                  if (snapshot.connectionState == ConnectionState.active) {
                    List _documents = snapshot.data!.docs;
                    _totaitems = _documents.length;
                  }

                  return Text(
                    '${_totaitems}' ?? '0',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
