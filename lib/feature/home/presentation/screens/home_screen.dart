import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/data/model/product_model.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/product/products_grid.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/product/products_listview.dart';

import '../../logic/home_cubit.dart';
import '../widgets/homescreen_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            final List<ProductModel> allProducts = context.watch<HomeCubit>().products;
            final List<ProductModel> shuffledProducts = List.from(allProducts)..shuffle(Random());
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: ProductsListView(
                      products: shuffledProducts,
                    ),
                  ),
                  SizedBox(height: 100),
                  ProductsGridView(products: allProducts),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}








// Widget buildLoading() {
//   return Center(
//     child: CircularProgressIndicator(),
//   );
// }



//  RefreshIndicator(
                //   onRefresh: () {
                //     return context.read<HomeCubit>().getHomeData();
                //   },
            // );


                     // ProductsGrid(products: displayedProducts),






                      // SizedBox(height: 100),
                      // ConditionalBuilder(
                      //   condition: context.watch<HomeCubit>().products.isNotEmpty,
                      //   builder: (context) => ProductsGrid(
                      //       products: context.watch<HomeCubit>().products),
                      //   fallback: (context) => buildLoading(),
                      // ),