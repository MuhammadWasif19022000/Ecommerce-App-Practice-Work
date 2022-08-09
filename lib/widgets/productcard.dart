import 'package:ecommerce_practice/constants.dart';
import 'package:ecommerce_practice/screens/productpage.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  //final Function onPressed;
  final String imgUrl;
  final String title;
  final String price;
  const ProductCard(
      {Key? key,
      //required this.onPressed,
      required this.imgUrl,
      required this.title,
      required this.price,
      required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap : onPressed(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(productId: productId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        height: 350,
        margin: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        child: Stack(
          children: [
            Container(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  // '${(document.data()! as Map)['image'][0]}',
                  "$imgUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      // (document.data()! as Map)['name'] ?? "Product Name",
                      style: Constants.regualrHeading,
                    ),
                    Text(
                      price,
                      // '\$${(document.data()! as Map)['price']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
