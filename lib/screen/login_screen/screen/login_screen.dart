import 'package:bai_tap_cuoi_ky/base/button.dart';
import 'package:bai_tap_cuoi_ky/base/text_field.dart';
import 'package:bai_tap_cuoi_ky/constants/colors.dart';
import 'package:bai_tap_cuoi_ky/constants/spacing.dart';
import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: key,
              child: Column(
                children: [
                  AppInput(
                    hintText: 'Email',
                    label: 'Nhập email',
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      loginController.email = value;
                    },
                  ),
                  gapHeight(sp16),
                  AppInput(
                    label: 'Nhập mật khẩu',
                    hintText: 'Password',
                    isPassword: true,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
                  ),
                ],
              )),
          gapHeight(sp64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainButton(
                title: 'Đăng nhập',
                event: () {
                  if (key.currentState!.validate()) {
                    _handleLogin();
                  }
                },
              ),
              MainButton(
                title: 'Đăng ký',
                event: () {
                  if (key.currentState!.validate()) {

                  }
                },
              )
            ],
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<void> _handleLogin() async {
    final canLogin = await loginController.login();
    if (canLogin) {

    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: red_1,
          content: Text('Đăng nhập thất bại! Sai email hoặc mật khẩu.'),
        ),
      );
    }
  }
}
