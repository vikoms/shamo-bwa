import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../theme.dart';

class EditProfilePage extends StatefulWidget {
  static const ROUTE_NAME = "/edit-profile";
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: _buildAppBar(context),
      body: Container(
        padding: EdgeInsets.all(
          defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/image_profile.png",
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                  ),
                ),
                TextFormField(
                  style: primaryTextStyle,
                  decoration: InputDecoration(
                    hintText: "Your Name ...",
                    hintStyle: primaryTextStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: subtitleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                  ),
                ),
                TextFormField(
                  style: primaryTextStyle,
                  decoration: InputDecoration(
                    hintText: "Your Username ...",
                    hintStyle: primaryTextStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: subtitleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Address",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                  ),
                ),
                TextFormField(
                  style: primaryTextStyle,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Your Email ...",
                    hintStyle: primaryTextStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: subtitleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 87,
      backgroundColor: transparentColor,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
          color: primaryTextColor,
        ),
      ),
      title: Text(
        "Edit Profile",
        style: primaryTextStyle,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.check,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
