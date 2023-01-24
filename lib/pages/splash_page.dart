import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/pages/main_page.dart';
import 'package:shamo_clone/providers/product_provider.dart';
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
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    Navigator.pushNamed(context, MainPage.ROUTE_NAME);
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
