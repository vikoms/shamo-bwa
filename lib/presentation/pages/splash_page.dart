import 'package:flutter/material.dart';
import 'package:shamo_clone/helpers/auth_helper.dart';
import 'package:shamo_clone/presentation/pages/main_page.dart';
import 'package:shamo_clone/presentation/pages/sign_in_page.dart';
import 'package:shamo_clone/presentation/providers/home_page_provider.dart';
import 'package:shamo_clone/theme.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    Future.delayed(Duration(seconds: 1), () async {
      final token = await AuthHelper.getAccessToken();
      if (token == null || token == '') {
        Navigator.pushReplacementNamed(context, SignInPage.ROUTE_NAME);
      } else {
        Navigator.pushReplacementNamed(context, MainPage.ROUTE_NAME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/image_splash.png',
            ),
          )),
        ),
      ),
    );
  }
}
