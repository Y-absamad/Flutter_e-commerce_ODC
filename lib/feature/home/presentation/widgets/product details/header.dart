import 'package:flutter/material.dart';

import '../../../data/model/product_model.dart';

class Header extends StatelessWidget {
  final ProductModel product;
  const Header({super.key , required this.product});

  @override
  Widget build(BuildContext context) {
   return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "NEW ARRIVAL",
          style: TextStyle(
              color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          textAlign: TextAlign.center,
          product.title!,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$${product.price}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}

