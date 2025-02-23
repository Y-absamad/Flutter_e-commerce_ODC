import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/profile/presentation/profile_screen.dart';

import '../data/model/product_model.dart';
import '../logic/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFD6C8A), Color(0xFFFF9A8B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 20),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Condong Catur",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.notifications, color: Colors.white, size: 24),
              SizedBox(width: 16),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg",
                ),
              ),
            ],
          ),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
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
                          var user = context.watch<HomeCubit>().userData;
                          return Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "${user!.name!.firstname!} ${user.name!.lastname!}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Products",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                        condition:
                            context.read<HomeCubit>().products.isNotEmpty,
                        builder: (context) => buildLoaded(
                            context.watch<HomeCubit>().products, context),
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

Widget buildLoaded(List<ProductModel> products, BuildContext contextC) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    itemCount: products.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: BlocProvider.of<HomeCubit>(contextC)
                  ..getSingleProduct(products[index].id!),
                // child: ProductDetailsScreen(),
              ),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(products[index].image!),
        ),
        title: Text(products[index].title!),
        subtitle: Text(
          products[index].description!,
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
            onPressed: () async {
              // try {
              //   var data = context.read<HomeCubit>().product;
              //   await SQLHelper.add(
              //       data!.id.toString(),
              //       data.title!,
              //       data.description ?? "",
              //       data.image!,
              //       1,
              //       data.price!.toDouble());
              // } catch (e) {
              //   print(e);
              // }
            },
            icon: Icon(Icons.add_shopping_cart)),
      );
    },
  );
}

Widget buildError() {
  return Center(
    child: Text("Error"),
  );
}
