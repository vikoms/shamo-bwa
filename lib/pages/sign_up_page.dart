import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/pages/main_page.dart';
import 'package:shamo_clone/providers/auth_provider.dart';
import 'package:shamo_clone/theme.dart';
import 'package:shamo_clone/widgets/loading_button.dart';

class SignUpPage extends StatefulWidget {
  static const ROUTE_NAME = "/sign-up";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  _handleSignUp() async {
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    if (await provider.register(
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Berhasil Sign Up',
            style: primaryTextStyle,
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, MainPage.ROUTE_NAME);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal Sign Up',
            style: primaryTextStyle,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildNameField(),
              _buildUsernameField(),
              _buildEmailField(),
              _buildPasswordField(),
              _isLoading ? LoadingButton() : _buildSignUpButton(),
              Spacer(),
              _buildFooter()
            ],
          ),
        ),
      ),
    );
  }

  Container _buildFooter() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account ? ',
            style: subtitleTextStyle.copyWith(
              fontSize: 12,
              fontWeight: regular,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Sign In',
              style: purpleTextStyle.copyWith(
                fontSize: 12,
                fontWeight: bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSignUpButton() {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        child: Text(
          'Sign Up',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
        onPressed: _handleSignUp,
      ),
    );
  }

  Container _buildNameField() {
    return Container(
      margin: const EdgeInsets.only(
        top: 52,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
              height: 50,
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Image.asset(
                        'assets/icon_name.png',
                        width: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: "Your Full Name",
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Container _buildUsernameField() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
              height: 50,
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Image.asset(
                        'assets/icon_username.png',
                        width: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: usernameController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: "Your Username",
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Container _buildEmailField() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
              height: 50,
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Image.asset(
                        'assets/icon_email.png',
                        width: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      style: primaryTextStyle,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration.collapsed(
                        hintText: "Your Email",
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Container _buildPasswordField() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
              height: 50,
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Image.asset(
                        'assets/icon_password.png',
                        width: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: passwordController,
                      style: primaryTextStyle,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: "Your Password",
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign Up',
            style: primaryTextStyle.copyWith(
              fontSize: 24,
              fontWeight: medium,
            ),
          ),
          Text(
            'Register and Happy Shoping',
            style: subtitleTextStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
