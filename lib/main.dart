import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/pages/cart_page.dart';
import 'package:shamo_clone/pages/chat_page.dart';
import 'package:shamo_clone/pages/checkout_finish_page.dart';
import 'package:shamo_clone/pages/checkout_page.dart';
import 'package:shamo_clone/pages/edit_profile_page.dart';
import 'package:shamo_clone/pages/home_page.dart';
import 'package:shamo_clone/pages/main_page.dart';
import 'package:shamo_clone/pages/profile_page.dart';
import 'package:shamo_clone/pages/sign_in_page.dart';
import 'package:shamo_clone/pages/sign_up_page.dart';
import 'package:shamo_clone/pages/splash_page.dart';
import 'package:shamo_clone/pages/wishlist_page.dart';
import 'package:shamo_clone/providers/auth_provider.dart';
import 'package:shamo_clone/providers/page_provider.dart';
import 'package:shamo_clone/providers/product_provider.dart';

import 'pages/product_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          SplashPage.routeName: (contex) => const SplashPage(),
          ProductDetailPage.ROUTE_NAME: (contex) {
            return ProductDetailPage(
              product: "args",
            );
          },
          SignInPage.ROUTE_NAME: (context) => SignInPage(),
          SignUpPage.ROUTE_NAME: (context) => SignUpPage(),
          MainPage.ROUTE_NAME: (context) => MainPage(),
          HomePage.ROUTE_NAME: (context) => HomePage(),
          ChatPage.ROUTE_NAME: (context) => ChatPage(),
          CartPage.ROUTE_NAME: (context) => CartPage(),
          WishlistPage.ROUTE_NAME: (context) => WishlistPage(),
          ProfilePage.ROUTE_NAME: (context) => ProfilePage(),
          CheckoutPage.ROUTE_NAME: (context) => const CheckoutPage(),
          CheckoutFinish.ROUTE_NAME: (context) => const CheckoutFinish(),
          EditProfilePage.ROUTE_NAME: (context) => EditProfilePage(),
        },
      ),
    );
  }
}
