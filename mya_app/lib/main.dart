import 'package:flutter/material.dart';

void main() {
  runApp(const MyaApp());
}

class MyaApp extends StatelessWidget {
  const MyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mya - 먀비서',
      debugShowCheckedModeBanner: false, // 디버그 배너 숨김
      theme: ThemeData(
        // '먀비서'의 브랜드 컬러를 반영 (파란색 계열 제안)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // 초기 화면을 회원가입/온보딩 화면으로 설정
      home: const OnboardingScreen(),
    );
  }
}

/// 온보딩 및 회원가입 진입 화면
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.access_time_filled, size: 80, color: Colors.indigo),
              const SizedBox(height: 24),
              const Text(
                '똑똑한 외출 파트너, 먀비서',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                '개인별 준비 시간을 고려한\n맞춤형 일정 관리를 시작해보세요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  // TODO: 회원가입 및 준비 시간 설정 플로우로 이동
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: const Text('시작하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}