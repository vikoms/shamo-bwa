import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/pages/edit_profile_page.dart';
import 'package:shamo_clone/presentation/pages/my_transaction_page.dart';
import 'package:shamo_clone/utils/app_utils.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../../theme.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = "/profile-page";

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() =>
        Provider.of<ProfileProvider>(context, listen: false).getUserProfile());
  }

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
        GestureDetector(
            onTap: () => Navigator.pushNamed(
                  context,
                  MyTransactionPage.ROUTE_NAME,
                ),
            child: _buildMenu("Your Orders")),
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

  Widget _buildHeader() {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        if (value.state == RequestState.Loaded) {
          return Container(
            padding: EdgeInsets.all(defaultMargin),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: CachedNetworkImage(
                    width: 64,
                    height: 64,
                    imageUrl: value.user.profilePhotoUrl!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hallo, ${value.user.name}",
                        style: primaryTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "@${value.user.username}",
                        style: subtitleTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    value.logout(
                      context,
                      () => AppUtils.showSuccessSnackbar(
                        context,
                        "Logout Berhasil",
                      ),
                      (error) => AppUtils.showAlertSnackbar(context, error),
                    );
                  },
                  child: Image.asset(
                    "assets/button_exit.png",
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(defaultMargin),
            child: Row(
              children: [
                Image.asset(
                  "assets/image_profile.png",
                  width: 64,
                  height: 64,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Unknown",
                        style: primaryTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "Unknown",
                        style: subtitleTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    value.logout(
                      context,
                      () => AppUtils.showSuccessSnackbar(
                        context,
                        "Logout Berhasil",
                      ),
                      (error) => AppUtils.showAlertSnackbar(context, error),
                    );
                  },
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
      },
    );
  }
}
