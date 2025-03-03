
import 'package:flutter/material.dart';


class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    super.key,
    required this.title, required this.price,
  });

  final String title;
  final num price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.center,
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              "\$$price",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
