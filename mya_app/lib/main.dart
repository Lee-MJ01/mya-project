import 'package:flutter/material.dart';

// 디자이너 지정 컬러 시스템
const Color kTrustNavy = Color(0密A237E);
const Color kSmartMint = Color(0xFF26A69A);
const Color kActionOrange = Color(0xFFFF7043);

void main() {
  runApp(const MyaApp());
}

class MyaApp extends StatelessWidget {
  const MyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard', //
        colorScheme: ColorScheme.fromSeed(
          seedColor: kTrustNavy,
          primary: kTrustNavy,
          secondary: kSmartMint,
        ),
        useMaterial3: true,
      ),
      home: const MainDashboard(),
    );
  }
}