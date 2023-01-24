import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shamo_clone/pages/edit_profile_page.dart';

import '../theme.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = "/profile-page";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Container(
              color: backgroundColor3,
              padding: EdgeInsets.all(
                defaultMargin,
              ),
              child: Column(
                children: [
                  // ACCOUNT
                  _buildAccountSection(context),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  _buildGeneralSection(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildGeneralSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "General",
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
        _buildMenu("Privacy & Policy"),
        _buildMenu("Term of Service"),
        _buildMenu("Rate App"),
      ],
    );
  }

  Column _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account",
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, EditProfilePage.ROUTE_NAME);
          },
          child: _buildMenu("Edit Profile"),
        ),
        _buildMenu("Your Orders"),
        _buildMenu("Help"),
      ],
    );
  }

  Widget _buildMenu(String text) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: subtitleTextStyle.copyWith(
              fontSize: 13,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: secondaryTextColor,
          )
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: EdgeInsets.all(defaultMargin),
      child: Row(
        children: [
          Image.asset(
            "assets/image_profile.png",
            width: 64,
            height: 64,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hallo, Alex",
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "@alexkeinn",
                  style: subtitleTextStyle.copyWith(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              "assets/button_exit.png",
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
