import 'package:flutter/material.dart';

class ProductImageGridView extends StatelessWidget {
  const ProductImageGridView({
    super.key,
    required this.productImageURL,
  });

  final String productImageURL;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Image.network(
        productImageURL,
        fit: BoxFit.fill,
        width: 190,
        height: 195,
      ),
    );
  }
}

