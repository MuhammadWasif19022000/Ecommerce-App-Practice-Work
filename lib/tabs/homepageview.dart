import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/widgets/customaction.dart';
import 'package:ecommerce_practice/widgets/productcard.dart';
import 'package:flutter/material.dart';

import '../screens/productpage.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");
  HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productRef.get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error : ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return FutureBuilder(
                  future: _productRef.get(),
                  builder: (context, snaphot) {
                    return ListView(
                      padding: EdgeInsets.only(top: 108, bottom: 12),
                      children: snapshot.data!.docs.map((document) {
                        return ProductCard(
                          title: (document.data()! as Map)['name'],
                          imgUrl: (document.data()! as Map)['image'][0],
                          price: "\$${(document.data()! as Map)['price']}",
                          productId: document.id,
                          // onPressed: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ProductPage(
                          //         productId: document.id,
                          //       ),
                          //     ),
                          //   );
                          // },
                        );
                      }).toList(),
                    );
                  },
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasArrowBack: false,
            title: 'Home',
            hasTitle: true,
          ),
        ],
      ),
    );
  }
}
