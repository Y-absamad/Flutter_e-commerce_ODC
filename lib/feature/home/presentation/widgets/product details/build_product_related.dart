
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/logic/home_cubit.dart';

import '../../../../../core/widgets/products_listview.dart';
import '../../../data/model/product_model.dart';

class BuildProductRelated extends StatelessWidget {
  const BuildProductRelated({
    super.key,
    required this.allProducts,
    required this.product
  });

  final List<ProductModel> allProducts;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Product Related',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ProductsListView(
              products: context.read<HomeCubit>().getRelatedProducts(product, allProducts)),
        ),
      ],
    );
  }
 
}
