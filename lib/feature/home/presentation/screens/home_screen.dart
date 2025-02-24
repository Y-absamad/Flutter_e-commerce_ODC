import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/widgets/products_grid.dart';

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
            return RefreshIndicator(
              onRefresh: () {
                return context.read<HomeCubit>().getHomeData();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConditionalBuilder(
                        condition: context.watch<HomeCubit>().userData != null,
                        builder: (BuildContext context) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          );
                        },
                        fallback: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      //

                      SizedBox(height: 20),
                      Text(
                        "Products",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ConditionalBuilder(
                        condition:
                            context.watch<HomeCubit>().products.isNotEmpty,
                        builder: (context) => ProductsGrid(
                          products:
                            context.watch<HomeCubit>().products , contextC: context),
                        fallback: (context) => buildLoading(),
                      ),
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
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
