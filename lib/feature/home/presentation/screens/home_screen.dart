import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/data/model/product_model.dart';
import 'package:flutter_ecommerce_odc/core/widgets/products_grid.dart';
import 'package:flutter_ecommerce_odc/core/widgets/products_listview.dart';

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
            if (state is HomeProductsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final List<ProductModel> allProducts =
                  context.watch<HomeCubit>().products;
              final List<ProductModel> shuffledProducts = List.from(allProducts)
                ..shuffle(Random());
              return SingleChildScrollView(
                child: ConditionalBuilder(
                  condition: context.watch<HomeCubit>().products.isNotEmpty,
                  builder: (context) => Column(
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
                  fallback: (context) => buildLoading(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget buildLoading() {
  return SizedBox(
    height: 650,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}



//  RefreshIndicator(
                //   onRefresh: () {
                //     return context.read<HomeCubit>().getHomeData();
                //   },
            // );