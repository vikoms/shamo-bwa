import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/providers/profile_provider.dart';
import 'package:shamo_clone/utils/app_utils.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../../theme.dart';

class EditProfilePage extends StatefulWidget {
  static const ROUTE_NAME = "/edit-profile";
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ProfileProvider>(
          context,
          listen: false,
        ).getUserProfile());
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: _buildAppBar(context),
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          if (value.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.state == RequestState.Loaded) {
            nameController.text = value.user.name;
            emailController.text = value.user.email;
            usernameController.text = value.user.username;
            return SingleChildScrollView(
              child: Container(
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
                          controller: nameController,
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
                          controller: usernameController,
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
                          controller: emailController,
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
                    if (value.updateState == RequestState.Error)
                      Container(
                        margin: EdgeInsets.only(
                          top: 30,
                        ),
                        child: Text(
                          value.message,
                          style: alertTextStyle,
                        ),
                      )
                    else if (value.updateState == RequestState.Loading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Error",
                style: primaryTextStyle,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _submitForm() async {
    if (nameController.text.isEmpty) {
      AppUtils.showAlertSnackbar(context, "Harap masukkan nama");
      return;
    }

    if (usernameController.text.isEmpty) {
      AppUtils.showAlertSnackbar(context, "Harap masukkan username");
      return;
    }

    if (emailController.text.isEmpty) {
      AppUtils.showAlertSnackbar(context, "Harap masukkan email");
      return;
    }

    Provider.of<ProfileProvider>(context, listen: false).updateUserProfile(
      nameController.text,
      emailController.text,
      usernameController.text,
      () {
        Navigator.pop(context);
        AppUtils.showSuccessSnackbar(context, "Profile berhasil diubah");
      },
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
          onPressed: () async {
            await _submitForm();
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
