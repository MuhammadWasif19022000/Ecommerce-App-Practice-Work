// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/screens/login.dart';
import 'package:ecommerce_practice/servcies/firebase_services.dart';
import 'package:ecommerce_practice/tabs/homepageview.dart';
import 'package:ecommerce_practice/tabs/savedview.dart';
import 'package:ecommerce_practice/tabs/searchview.dart';
import 'package:ecommerce_practice/widgets/bottomtabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  late PageController _tabsPageControler;
  @override
  void initState() {
    _tabsPageControler = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageControler.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageControler,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
              ],
            ),
          ),
          BottomTabs(
            tabPressed: (num) {
              _tabsPageControler.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
            selectedTab: _selectedTab,
          ),
        ],
      ),
    );
  }
}
