import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/screens/productpage.dart';
import 'package:ecommerce_practice/servcies/firebase_services.dart';
import 'package:ecommerce_practice/widgets/customaction.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FireabseServices _fireabseServices = FireabseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _fireabseServices.userRef
                .doc(_fireabseServices.getUserId())
                .collection('Cart')
                .get(),
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
                  future: _fireabseServices.productRef.get(),
                  builder: (context, snaphot) {
                    return ListView(
                      padding: EdgeInsets.only(top: 108, bottom: 12),
                      children: snapshot.data!.docs.map((document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(productId: document.id),
                              ),
                            );
                          },
                          child: FutureBuilder(
                            future: _fireabseServices.productRef
                                .doc(document.id)
                                .get(),
                            builder: ((context, AsyncSnapshot productsnap) {
                              if (productsnap.hasError) {
                                return Center(
                                  child: Text('${productsnap.hasError}'),
                                );
                              }
                              if (productsnap.connectionState ==
                                  ConnectionState.done) {
                                Map _productMap = productsnap.data!.data();

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            // '${(document.data()! as Map)['image'][0]}'
                                            "${_productMap['image'][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_productMap['name']}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                              ),
                                              child: Text(
                                                "\$${_productMap['price']}",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Text(
                                              "Size - ${document['size']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }),
                          ),
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
            hasArrowBack: true,
            hasTitle: true,
            title: 'Cart',
          )
        ],
      ),
    );
  }
}
