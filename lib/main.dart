import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/presentation/pages/cart_page.dart';
import 'package:shamo_clone/presentation/pages/chat_page.dart';
import 'package:shamo_clone/presentation/pages/checkout_finish_page.dart';
import 'package:shamo_clone/presentation/pages/checkout_page.dart';
import 'package:shamo_clone/presentation/pages/edit_profile_page.dart';
import 'package:shamo_clone/presentation/pages/home_page.dart';
import 'package:shamo_clone/presentation/pages/main_page.dart';
import 'package:shamo_clone/presentation/pages/my_transaction_page.dart';
import 'package:shamo_clone/presentation/pages/profile_page.dart';
import 'package:shamo_clone/presentation/pages/sign_in_page.dart';
import 'package:shamo_clone/presentation/pages/sign_up_page.dart';
import 'package:shamo_clone/presentation/pages/splash_page.dart';
import 'package:shamo_clone/presentation/pages/wishlist_page.dart';
import 'package:shamo_clone/presentation/providers/auth_provider.dart';
import 'package:shamo_clone/presentation/providers/checkout_provider.dart';
import 'package:shamo_clone/presentation/providers/page_provider.dart';
import 'package:shamo_clone/presentation/providers/product_detail_provider.dart';
import 'package:shamo_clone/presentation/providers/home_page_provider.dart';
import 'package:shamo_clone/presentation/providers/profile_provider.dart';
import 'package:shamo_clone/presentation/providers/transaction_provider.dart';
import 'package:shamo_clone/presentation/providers/wishlist_provider.dart';
import 'injection.dart' as di;

import 'presentation/pages/product_detail_page.dart';
import 'presentation/providers/cart_provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => di.locator<HomePageProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<ProfileProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ProductDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WishlistProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CartProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CheckoutProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TransactionProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Shamo App By Viko',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: ((settings) {
          switch (settings.name) {
            case SplashPage.routeName:
              return MaterialPageRoute(builder: (_) => SplashPage());
            case ProductDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => ProductDetailPage(productId: id));
            case SignInPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SignInPage());
            case SignUpPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SignUpPage());
            case MainPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => MainPage());

            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomePage());
            case ChatPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => ChatPage());
            case CartPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => CartPage());
            case WishlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WishlistPage());
            case ProfilePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => ProfilePage());
            case CheckoutPage.ROUTE_NAME:
              final carts = settings.arguments as List<Cart>;
              return MaterialPageRoute(
                  builder: (_) => CheckoutPage(
                        carts: carts,
                      ));
            case CheckoutFinish.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => CheckoutFinish());
            case EditProfilePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => EditProfilePage());
            case MyTransactionPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => MyTransactionPage());
          }
        }),
      ),
    );
  }
}
