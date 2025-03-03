import 'package:flutter/material.dart';

class ProductImageList extends StatelessWidget {
  const ProductImageList({
    super.key,
    required this.productImageURL,
  });

  final String productImageURL;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Stack(
        children: [
          const Positioned(
            top: 95,
            left: 80,
            child: CircularProgressIndicator(),
          ),
          Image.network(
            productImageURL,
            fit: BoxFit.fill,
            width: 190,
            height: 155,
          ),
        ],
      ),
    );
  }
}
