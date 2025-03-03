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
                      buildOfferCard(),
                      SizedBox(height: 160),
                      buildHotDeals(),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 250,
                        child: ProductsListView(
                          products: shuffledProducts,
                        ),
                      ),
                      SizedBox(height: 20),
                      buildCategoryList(),
                      SizedBox(height: 20),
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

Widget buildOfferCard() {
  return Stack(
    clipBehavior: Clip.none, 
    children: [
      Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xffFD6c8A), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              const Text(
                'Find best device for your setup!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: -130, 
        left: 15,
        right: 15,
        child: Container(
          height: 196,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6F68E8),
                Color.fromARGB(255, 137, 133, 210)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "New Bing\nWireless \nEarphone",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text(
                          "See Offer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 5,
                bottom: 5,
                child: Image.asset(
                  "assets/imageSvg/headset.png",
                  height: 190,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}


Widget buildHotDeals() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        const Text(
          "Hot deals🔥",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        buildTimerBox("02"),
        const Text(" : "),
        buildTimerBox("12"),
        const Text(" : "),
        buildTimerBox("00"),
      ],
    ),
  );
}

Widget buildTimerBox(String value) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      value,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildCategoryList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          buildCategoryItem(
            icon: Icons.apps, 
            label: "All", 
            isSelected: true,
          ),
          const SizedBox(width: 10),
          buildCategoryItem(
            icon: Icons.laptop_mac, 
            label: "Laptop", 
            isSelected: false,
          ),
          const SizedBox(width: 10),
          buildCategoryItem(
            icon: Icons.headphones, 
            label: "Accessories", 
            isSelected: false,
          ),
        ],
      ),
    );
  }

Widget buildCategoryItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black54,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
