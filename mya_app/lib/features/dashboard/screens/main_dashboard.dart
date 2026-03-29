class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildTopCountdownWidget(), // 상단 위젯
      body: Row(
        children: [
          // 왼쪽: Schedule Track (고정 일정)
          Expanded(flex: 1, child: _buildScheduleTrack()),
          // 오른쪽: Transit Track (유동 이동 시간)
          Expanded(flex: 1, child: _buildTransitTrack()),
        ],
      ),
      floatingActionButton: _buildHybridRecordButton(), // 원클릭 녹음 버튼 [cite: 19]
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomSheet: const AlarmStackWidget(), // 알람 스택
    );
  }

  // 상단 카운트다운 위젯
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
}