import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/servcies/firebase_services.dart';
import 'package:ecommerce_practice/widgets/customfield.dart';
import 'package:flutter/material.dart';

import '../widgets/productcard.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    FireabseServices _firebaseSevices = FireabseServices();

    String _search = "";
    return Container(
      child: Stack(
        children: [
          if (_search.isEmpty)
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 150),
                child: Text(
                  'Search Results',
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseSevices.productRef
                  .orderBy('searchString')
                  .startAt([_search]).endAt([_search + '\uf8ff']).get(),
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
                    future: _firebaseSevices.productRef.get(),
                    builder: (context, snaphot) {
                      return ListView(
                        padding: EdgeInsets.only(
                          top: 128,
                          bottom: 12,
                        ),
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

          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: CustomField(
              isPasswordField: false,
              hintText: "Search here",
              onchanged: (value) {},
              onsubmit: (value) {
                setState(() {
                  _search = value.toLowerCase();
                });
              },
            ),
          ),
          // Text(
          //   "Search Results",
          //   style: Constants.regularDarkText,
          // ),
        ],
      ),
    );
  }
}
