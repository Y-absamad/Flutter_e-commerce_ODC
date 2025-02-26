import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/logic/home_cubit.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/screens/product_details_screen.dart';
import '../../../data/model/product_model.dart';
import 'product_image_grid_view.dart';
import 'product_image_list_view.dart';
import 'product_info_section.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> relatedProducts;
  final bool isGrid;

  const ProductItem({super.key, required this.product, this.isGrid = false , required this.relatedProducts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isGrid ? double.infinity : 200,
      child: Card(
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
                      HomeCubit()..getSingleProduct(product.id!),
                  child: ProductDetailsScreen(allProducts: relatedProducts,),
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isGrid
                  ? ProductImageGrid(productImageURL: product.image!)
                  : ProductImageList(productImageURL: product.image!),
              ProductInfoSection(product: product),
            ],
          ),
        ),
      ),
    );
  }
}

