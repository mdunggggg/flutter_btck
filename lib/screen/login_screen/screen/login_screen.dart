import 'package:bai_tap_cuoi_ky/base/button.dart';
import 'package:bai_tap_cuoi_ky/base/loading.dart';
import 'package:bai_tap_cuoi_ky/base/text_field.dart';
import 'package:bai_tap_cuoi_ky/constants/colors.dart';
import 'package:bai_tap_cuoi_ky/constants/spacing.dart';
import 'package:bai_tap_cuoi_ky/screen/home/screen/home_screen.dart';
import 'package:bai_tap_cuoi_ky/screen/register/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  final loginController = LoginController();
  final emailController = TextEditingController();
  var isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(sp16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/jsons/welcome.json',
            ),
            Form(
              key: key,
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) {
                      return value
                          ? const BaseLoading()
                          : const SizedBox.shrink();
                    },
                  ),
                  Column(
                    children: [
                      AppInput(
                        hintText: 'Email',
                        controller: emailController,
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
                        onChanged: (value) {
                          loginController.password = value;
                        },
                        isPassword: true,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            gapHeight(sp64),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MainButton(
                    title: 'Đăng nhập',
                    event: () {
                      if (key.currentState!.validate()) {
                        _handleLogin();
                      }
                    },
                  ),
                ),
                gapWidth(sp12),
                Expanded(
                  child: ExtraButton(
                    title: 'Đăng ký',
                    event: () {
                      _handleRegister();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<void> _handleLogin() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    final canLogin = await loginController.login();
    if (canLogin) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: red_1,
          content: Text('Đăng nhập thất bại! Sai email hoặc mật khẩu.'),
        ),
      );
    }
    isLoading.value = false;
  }

  void _handleRegister() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    )
        .then((value) {
      if (value != null && value['success']) {
        emailController.text = value['email'];
      }
    });
  }
}
