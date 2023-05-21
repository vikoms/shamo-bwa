import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/pages/main_page.dart';
import 'package:shamo_clone/presentation/providers/auth_provider.dart';
import 'package:shamo_clone/theme.dart';
import 'package:shamo_clone/presentation/widgets/loading_button.dart';

class SignUpPage extends StatefulWidget {
  static const ROUTE_NAME = "/sign-up";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _registerData = {
    'email': '',
    'password': '',
    'username': '',
    'name': '',
  };

  _handleSignUp() async {
    if (_formKey.currentState?.validate() == false) {
      // Invalid!
      return;
    }
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);

    _formKey.currentState?.save();

    await provider.register(
        name: _registerData['name'] ?? "",
        username: _registerData['username'] ?? "",
        email: _registerData['email'] ?? "",
        password: _registerData['password'] ?? "",
        onFailure: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gagal Sign Up',
                style: primaryTextStyle,
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Berhasil Sign Up',
                style: primaryTextStyle,
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, MainPage.ROUTE_NAME);
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildNameField(),
                      _buildUsernameField(),
                      _buildEmailField(),
                      _buildPasswordField(),
                      Consumer<AuthProvider>(
                        builder: ((context, value, child) {
                          if (value.isLoading) {
                            return LoadingButton();
                          }
                          return _buildSignUpButton();
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                _buildFooter()
              ],
            ),
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
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: "Your Full Name",
                        hintStyle: subtitleTextStyle,
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Please fill name first";
                        }
                      },
                      onSaved: (value) {
                        _registerData['name'] = value ?? "";
                      },
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
                    style: primaryTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: "Your Username",
                      hintStyle: subtitleTextStyle,
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return "Please fill username first";
                      }
                    },
                    onSaved: (value) {
                      _registerData['username'] = value ?? "";
                    },
                  ),
                ),
              ],
            ),
          )
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
                      style: primaryTextStyle,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration.collapsed(
                        hintText: "Your Email",
                        hintStyle: subtitleTextStyle,
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Please fill email first";
                        }
                      },
                      onSaved: (value) {
                        _registerData['email'] = value ?? "";
                      },
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
                      style: primaryTextStyle,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: "Your Password",
                        hintStyle: subtitleTextStyle,
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Please fill password first";
                        }
                      },
                      onSaved: (value) {
                        _registerData['password'] = value ?? "";
                      },
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
