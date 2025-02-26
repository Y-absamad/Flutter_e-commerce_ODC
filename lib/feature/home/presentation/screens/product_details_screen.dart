import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/core/widgets/custom_button.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/product/products_listview.dart';

import '../../logic/home_cubit.dart';
import '../../data/model/product_model.dart';

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
        _buildProductTitle(product),
        const SizedBox(height: 12),
        _buildProductImage(product.image!),
        const SizedBox(height: 12),
        _buildColorSelection(),
        const SizedBox(height: 16),
        _buildProductDescription(product),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ProductsListView(products: context.read<HomeCubit>().getRelatedProducts(product, allProducts)),
        )
      ],
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductTitle(ProductModel product) {
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

  Widget _buildColorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Available Colors", style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _colorOption(Colors.black, isSelected: true),
            const SizedBox(width: 10),
            _colorOption(Colors.grey),
            const SizedBox(width: 10),
            _colorOption(Colors.white),
          ],
        ),
      ],
    );
  }

  Widget _colorOption(Color color, {bool isSelected = false}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
      ),
    );
  }

  Widget _buildProductDescription(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Description",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          product.description!,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}