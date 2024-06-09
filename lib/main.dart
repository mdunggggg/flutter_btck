import 'package:bai_tap_cuoi_ky/screen/home/screen/home_screen.dart';
import 'package:bai_tap_cuoi_ky/screen/login_screen/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/local/database/app_database.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.initDatabase(); // Khởi tạo database
  await Firebase.initializeApp( // Khởi tạo Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(  // Kiểm tra trạng thái đăng nhập của người dùng
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData ) { // Nếu đã đăng nhập thì chuyển hướng đến màn hình HomeScreen
            return const HomeScreen();
          }
          // Nếu chưa đăng nhập thì chuyển hướng đến màn hình LoginScreen
          return const LoginScreen();
        },
      ),
      // Cấu hình ngôn ngữ cho ứng dụng
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Cấu hình ngôn ngữ mặc định cho ứng dụng
      supportedLocales: const [
        Locale('en'), // English
        Locale('vi'), // Spanish
      ],
    );
  }
}
