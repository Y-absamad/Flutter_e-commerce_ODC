import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/core/database/sql_helper.dart';
import 'package:flutter_ecommerce_odc/core/network/dio_helper.dart';

import 'feature/card/logic/cart_cubit.dart';
import 'feature/splash_screen.dart';
import 'feature/wishlist/logic/wishlist_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLHelper.initDb();
  DioHelper.init();
  runApp(
   MultiBlocProvider( 
      providers: [
        BlocProvider(create: (context) => CartCubit()..getCartData()),
        BlocProvider(create: (context) => WishlistCubit()..initDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
    );
  }
}
