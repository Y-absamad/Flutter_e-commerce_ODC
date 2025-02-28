import 'dart:math'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/logic/home_cubit.dart';
import 'package:flutter_ecommerce_odc/core/widgets/products_grid.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: _buildSearchBar(),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().getHomeData(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const SizedBox(height: 10),
                      context.watch<HomeCubit>().products.isNotEmpty
                          ? ProductsGridView(
                              products: context.watch<HomeCubit>().products..shuffle(Random()),
                            )
                          : const Center(child: CircularProgressIndicator(),),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: const TextField(
              decoration:  InputDecoration(
                hintText: "Search for products...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
