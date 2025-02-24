
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_odc/feature/home/data/model/product_model.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductModel> products;
  final BuildContext contextC;

  const ProductsGrid({super.key, required this.products , required this.contextC});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductItem(product: products[index] , contextC: contextC,);
      },
    );
  }
}
