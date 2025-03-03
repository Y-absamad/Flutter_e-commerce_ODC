import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/screens/product_details_screen.dart';
import 'package:flutter_ecommerce_odc/feature/wishlist/data/wishlist_model.dart';
import 'package:flutter_ecommerce_odc/feature/wishlist/logic/wishlist_cubit.dart';

import '../home/logic/home_cubit.dart';
import '../home/presentation/widgets/product/product_image_list_view.dart';
import '../home/presentation/widgets/product/product_info_section.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.watch<WishlistCubit>();
        return Scaffold(
          appBar: AppBar(title: const Text('Wish List') , centerTitle: true,),
          body: _buildBody(cubit, state),
        );
      },
    );
  }

  Widget _buildBody(WishlistCubit cubit, WishlistState state) {
    return ConditionalBuilder(
      condition: state is! WishlistLoading && state is! WishlistError,
      builder: (context) {
        if (cubit.wishlistItems.isEmpty) {
          return const Center(
            child: Text(
              "Your Wishlist is empty!",
              style: TextStyle(fontSize: 25, color: Colors.grey),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 1,
                childAspectRatio: 0.8,
              ),
              itemCount: cubit.wishlistItems.length,
              itemBuilder: (context, index) {
                WishlistModel item = cubit.wishlistItems[index];
                return SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  HomeCubit()..getSingleProduct(item.id!),
                                  child: ProductDetailsScreen(allProducts: []),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductImageGrid(productImageURL: item.image!),
                          ProductInfoSection(
                            title: item.title!,
                            price: item.price!,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
      fallback: (context) {
        if (state is WishlistLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WishlistError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('حدث خطأ غير متوقع'));
        }
      },
    );
  }
}
