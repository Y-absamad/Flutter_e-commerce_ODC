import 'package:flutter/material.dart';

class ProductImageGrid extends StatelessWidget {
  const ProductImageGrid({
    super.key,
    required this.productImageURL,
  });

  final String productImageURL;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Stack(
          children: [
            Center(child: CircularProgressIndicator(),),
            Image.network(
              productImageURL,
              fit: BoxFit.fill,
              width: double.infinity,
              height: 180,
            ),
          ],
        ),
      ),
    );
  }
}
