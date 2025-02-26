
import 'package:flutter/material.dart';

import 'expandable_text.dart';

class BuildProductDescription extends StatelessWidget {
  const BuildProductDescription({
    super.key,
    required this.productDescription,
  });

  final String productDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Description",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ExpandableText(text: productDescription),
      ],
    );
  }
}
