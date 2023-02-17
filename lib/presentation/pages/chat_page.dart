import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/providers/page_provider.dart';
import 'package:shamo_clone/theme.dart';

class ChatPage extends StatefulWidget {
  static const ROUTE_NAME = "/chat-page";

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider provider = Provider.of<PageProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        toolbarHeight: 87,
        backgroundColor: transparentColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Message Support",
          style: primaryTextStyle,
        ),
      ),
      body: _buildEmptyState(provider),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: EdgeInsets.all(defaultMargin),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27),
              image: DecorationImage(
                image: AssetImage("assets/image_shop_logo.png"),
              ),
            ),
          ),
          title: Text(
            "Shoe Store",
            style: primaryTextStyle.copyWith(fontSize: 15),
          ),
          subtitle: Text(
            "Good night, This item is on",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: secondaryTextStyle,
          ),
          trailing: Text(
            "Now",
            style: secondaryTextStyle.copyWith(
              fontSize: 10,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(top: 12),
          height: 1,
          color: Color(0x2B2939),
        );
      },
      itemCount: 10,
    );
  }

  Center _buildEmptyState(PageProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icon_headset.png",
            width: 74,
            height: 62,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Oops... This feature is not yet available",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "We will release this feature as soon as possible",
            style: subtitleTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            width: 152,
            height: 44,
            child: TextButton(
              onPressed: () {
                provider.currentIndex = 0;
              },
              child: Text(
                "Explore Store",
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
