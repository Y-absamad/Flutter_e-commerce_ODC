import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/screens/home_screen.dart';
import 'package:flutter_ecommerce_odc/feature/intro/on%20board/presentation/onboard_screens.dart';

import 'home/presentation/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  String? token;

  @override
  void initState() {
    //CacheHelper.init();
    //token = CacheHelper.getData(key: "token");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: FlutterSplashScreen.fadeIn(
          //nextScreen: token != null ? HomeScreen() : LoginScreen(),
          //nextScreen: OnboardScreens(),
          nextScreen: Home(),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 3515),
          onInit: () async {},
          onEnd: () async {
            debugPrint("onEnd 1");
          },
          childWidget: SizedBox(
            height: 200,
            width: 200,
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/1280px-Amazon_logo.svg.png",
            ),
          ),
        ),
    );
  }
}
