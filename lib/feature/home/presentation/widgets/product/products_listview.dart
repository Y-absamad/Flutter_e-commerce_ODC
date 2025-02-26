import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_odc/feature/home/data/model/product_model.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/product/product_item.dart';

class ProductsListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductsListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ProductItem(product: products[index] , relatedProducts: products,),
        );
      },
    );
  }
}
