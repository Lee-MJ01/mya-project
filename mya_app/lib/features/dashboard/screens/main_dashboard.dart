import 'package:flutter/material.dart';
import 'package:mya_project/core/constants.dart'; // 색상 불러오기
import 'package:mya_project/features/dashboard/widgets/alarm_stack.dart'; // 알람 스택 불러오기

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildTopCountdownWidget(),
      body: Row(
        children: [
          Expanded(flex: 1, child: _buildScheduleTrack()),
          Expanded(flex: 1, child: _buildTransitTrack()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // 음성 녹음 로직 연결 예정
        backgroundColor: kSmartMint,
        child: const Icon(Icons.mic, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // const 에러 해결: AlarmStackWidget은 내부에서 변수(Opacity 등)를 사용할 수 있으므로
      // 부모에서 const를 제거하는 것이 안전합니다.
      bottomSheet: AlarmStackWidget(),
    );
  }

  PreferredSizeWidget _buildTopCountdownWidget() {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: kTrustNavy,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('다음 일정까지 45분 남았어요', style: TextStyle(color: Colors.white, fontSize: 14)),
          Text('오전 10:20분에 출발하세요', style: TextStyle(color: kSmartMint, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 보조 위젯 정의 (누락되었던 부분 추가)
  Widget _buildScheduleTrack() => const Center(child: Text('일정 트랙'));
  Widget _buildTransitTrack() => const Center(child: Text('이동 트랙'));
}