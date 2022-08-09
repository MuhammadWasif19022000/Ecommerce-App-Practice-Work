import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/widgets/customaction.dart';
import 'package:ecommerce_practice/widgets/imageswipe.dart';
import 'package:ecommerce_practice/widgets/prosize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../servcies/firebase_services.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FireabseServices _firebaseServices = FireabseServices();

  // User? _user = FirebaseAuth.instance.currentUser;
  String _selectedproductsizes = "0";

  Future _addToCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedproductsizes});
  }

  Future _addToSaved() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedproductsizes});
  }

  final SnackBar _snackbar =
      SnackBar(content: Text('Product Added to the Cart'));
  final SnackBar _snackbars =
      SnackBar(content: Text('Product Added to the Saved'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: _firebaseServices.productRef.doc(widget.productId).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('${snapshot.error}'),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentData =
                  snapshot.data!.data() as Map<String, dynamic>;
              List imageList = documentData['image'];
              List sizeList = documentData['size'];
              _selectedproductsizes = sizeList[0];
              return ListView(
                padding: EdgeInsets.all(0),
                children: [
                  ImageSwipe(imageList: imageList),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 4, left: 24, right: 24, top: 24),
                    child: Text("${(documentData)['name']}",
                        style: Constants.boldHeading),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                    child: Text(
                      "\$${(documentData)['price']}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Text(
                      "${(documentData)['desc']}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    child: Text(
                      'Select Size',
                      style: Constants.regularDarkText,
                    ),
                  ),
                  ProSize(
                    onselected: (size) {
                      _selectedproductsizes = size;
                    },
                    sizeList: sizeList,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _addToSaved();
                            Scaffold.of(context).showSnackBar(_snackbars);
                          },
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Color(0xffdcdcdc),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.bookmark_outline,
                              //     size: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              Scaffold.of(context).showSnackBar(_snackbar);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
                              height: 65,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
          hasTitle: false,
          hasbackground: false,
        )
      ],
    ));
  }
}
