import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_odc/core/network/dio_helper.dart';

import 'feature/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  DioHelper.init();
  runApp(MyApp());
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
