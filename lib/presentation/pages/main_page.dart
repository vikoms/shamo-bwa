import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/pages/cart_page.dart';
import 'package:shamo_clone/presentation/pages/chat_page.dart';
import 'package:shamo_clone/presentation/pages/home_page.dart';
import 'package:shamo_clone/presentation/pages/profile_page.dart';
import 'package:shamo_clone/presentation/pages/wishlist_page.dart';
import 'package:shamo_clone/presentation/providers/page_provider.dart';
import 'package:shamo_clone/theme.dart';

class MainPage extends StatefulWidget {
  static const ROUTE_NAME = "/main";
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomePage();

        case 1:
          return ChatPage();

        case 2:
          return WishlistPage();

        case 3:
          return ProfilePage();

        default:
          return HomePage();
      }
    }

    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CartPage.ROUTE_NAME);
        },
        backgroundColor: secondaryColor,
        child: Image.asset(
          "assets/icon_cart.png",
          width: 20,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: BottomNavigationBar(
            backgroundColor: backgroundColor4,
            currentIndex: pageProvider.currentIndex,
            onTap: ((value) {
              pageProvider.currentIndex = value;
            }),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    "assets/icon_home.png",
                    width: 21,
                    color: pageProvider.currentIndex == 0
                        ? primaryColor
                        : Color(0xFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    "assets/icon_chat.png",
                    width: 21,
                    color: pageProvider.currentIndex == 1
                        ? primaryColor
                        : Color(0xFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    "assets/icon_wishlist.png",
                    width: 21,
                    color: pageProvider.currentIndex == 2
                        ? primaryColor
                        : Color(0xFF808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    "assets/icon_profile.png",
                    width: 21,
                    color: pageProvider.currentIndex == 3
                        ? primaryColor
                        : Color(0xFF808191),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          pageProvider.currentIndex == 0 ? backgroundColor1 : backgroundColor3,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartButton(),
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
