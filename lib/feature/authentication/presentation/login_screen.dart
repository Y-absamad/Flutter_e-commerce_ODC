import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/feature/home/presentation/home.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_input.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../logic/auth_cubit.dart';
import 'register_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginLoading) {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is AuthLoginSuccess) {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
                (router) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success Login"),
                ),
              );
            }

            if (state is AuthLoginFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    Text(
                      "Login to your \naccount.",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 24),
                    CustomTextInput(
                      hintText: 'Enter Your Username',
                      labelText: 'Username',
                      controller: userNameController,
                    ),
                    SizedBox(height: 24),
                    CustomTextInput(
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    SizedBox(height: 24),
                    CustomButton(
                      label: 'Login',
                      onPressed: () {
                        context.read<AuthCubit>().login(
                              userNameController.text,
                              passwordController.text,
                            );
                      },
                    ),
                    SizedBox(height: 24),
                    CustomButton(
                      label: 'Register',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
