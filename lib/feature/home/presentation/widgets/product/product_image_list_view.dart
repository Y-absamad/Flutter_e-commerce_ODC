import 'package:flutter/material.dart';

class ProductImageListView extends StatelessWidget {
  const ProductImageListView({
    super.key,
    required this.productImageURL,
  });

  final String productImageURL;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Image.network(
          productImageURL,
          fit: BoxFit.fill,
          width: double.infinity,
          height: 180,
        ),
      ),
    );
  }
}
