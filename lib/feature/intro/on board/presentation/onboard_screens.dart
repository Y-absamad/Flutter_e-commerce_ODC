import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_odc/feature/authentication/presentation/login_screen.dart';
import 'package:flutter_ecommerce_odc/feature/intro/on%20board/model/onborad_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardScreens extends StatefulWidget {
  const OnboardScreens({super.key});

  @override
  State<OnboardScreens> createState() => _OnboardScreensState();
}

class _OnboardScreensState extends State<OnboardScreens> {
  List<OnboradModel> onboradModel = [
    OnboradModel(
        imagePath: 'assets/imageSvg/onborad1.svg',
        title: 'Find the item you\'ve been looking for',
        subTitle:
            "Here you'll see rich varieties of goods, carefully classified for seamless browsing experience"),
    OnboradModel(
        imagePath: 'assets/imageSvg/onborad2.svg',
        title: 'Get those shopping bags filled',
        subTitle:
            "Add any item you want to your cart or save it on your wishlist, so you don't miss it in your future purchase."),
    OnboradModel(
        imagePath: 'assets/imageSvg/onborad3.svg',
        title: 'Fast & Secure payment',
        subTitle:
            "There are many payment options available to speed up and simplify your payment process."),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          children: [
            SizedBox(height: 175),
            SizedBox(
              height: 400,
              child: SvgPicture.asset(
                onboradModel[index].imagePath,
              ),
            ),
            SizedBox(height: 10),
            Text(
              onboradModel[index].title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Text(onboradModel[index].subTitle, textAlign: TextAlign.center),
            SizedBox(height: 100),
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 30,
              child: IconButton(
                  onPressed: () {
                    if (index == onboradModel.length - 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } else {
                      setState(() {
                        index++;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
