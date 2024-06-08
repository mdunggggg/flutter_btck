import 'package:bai_tap_cuoi_ky/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../base/button.dart';
import '../../../base/text_field.dart';
import '../../../constants/spacing.dart';
import '../controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final key = GlobalKey<FormState>();
  final registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(sp16),
        child: Column(
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
                      registerController.email = value;
                    },
                  ),
                  gapHeight(sp16),
                  AppInput(
                    label: 'Nhập mật khẩu',
                    hintText: 'Password',
                    isPassword: true,
                    onChanged: (value) {
                      registerController.password = value;
                    },
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
                  ),
                  gapHeight(sp16),
                  AppInput(
                    label: 'Xác nhận mật khẩu',
                    hintText: 'Xác nhận mật khẩu',
                    isPassword: true,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      if (value != registerController.password) {
                        return 'Mật khẩu không khớp';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            gapHeight(sp64),
            MainButton(
              title: 'Đăng ký',
              event: () {
                if (key.currentState!.validate()) {
                  _handleRegister();
                }
              },
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<void> _handleRegister() async {
    final canRegis = await registerController.register();
    if (canRegis) {
      Navigator.of(context).pop({
        'success': true,
        'email': registerController.email,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: red_1,
          content: Text('Đăng ký thất bại'),
        ),
      );
    }
  }
}