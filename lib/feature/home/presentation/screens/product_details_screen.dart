import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/core/widgets/custom_button.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/product%20details/header.dart';

import '../../../../core/database/sql_helper.dart';
import '../../../card/logic/cart_cubit.dart';
import '../../../wishlist/data/wishlist_model.dart';
import '../../../wishlist/logic/wishlist_cubit.dart';
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
        final wishlistCubit = context.watch<WishlistCubit>();
        final isInWishlist = wishlistCubit.wishlistItems.any((item) => item.id == product?.id);

        if (product == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () async {
                  if (isInWishlist) {
                        await wishlistCubit.removeFromWishlist(product.id!);
                      } else {
                        final WishlistModel wishlistItem = WishlistModel(
                          id: product.id,
                          title: product.title,
                          description: product.description,
                          image: product.image,
                          price: product.price?.toDouble(),
                        );
                        await wishlistCubit.addToWishlist(wishlistItem);
                      }
                },
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                ),
              ),
            ],
          ),
          body: _buildProductDetails(product),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    try {
                      await SQLHelper.addProduct(
                          product.id.toString(),
                          product.title!,
                          product.description ?? "",
                          product.image!,
                          1,
                          product.price!.toDouble());
                      context.read<CartCubit>().refreshCart();
                    } catch (e) {
                      print('Error adding to cart: $e');
                    }
                  },
                  icon: Icon(Icons.shopping_bag_outlined, size: 30),
                ),
                Expanded(
                  child: CustomButton(
                    label: 'Checkout',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails(ProductModel product) {
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
        BuildProductRelated(allProducts: allProducts, product: product),
      ],
    );
  }
}
