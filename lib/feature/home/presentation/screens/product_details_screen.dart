import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/core/widgets/custom_button.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/product%20details/header.dart';

import '../../logic/home_cubit.dart';
import '../../data/model/product_model.dart';
import '../widgets/product details/build_description.dart';
import '../widgets/product details/build_image.dart';
import '../widgets/product details/build_product_related.dart';
import '../widgets/product details/color_selection.dart';

class ProductDetailsScreen extends StatelessWidget {
  final List<ProductModel> allProducts;
  const ProductDetailsScreen({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final ProductModel? product = context.read<HomeCubit>().product;

        if (product == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: _buildProductDetails(product, context),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              label: 'Checkout',
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails(ProductModel product, BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Header(product: product),
        const SizedBox(height: 12),
        BuildImage(imageUrl: product.image!),
        const SizedBox(height: 12),
        ColorSelection(),
        const SizedBox(height: 16),
        BuildProductDescription(productDescription: product.description!),
        const SizedBox(height: 16),
        BuildProductRelated(allProducts: allProducts , product: product),
      ],
    );
  }
}