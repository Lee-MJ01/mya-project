class AlarmStackWidget extends StatelessWidget {
  const AlarmStackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // 스택 형태로 쌓이는 알람 카드 예시
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: Card(
              color: kActionOrange.withOpacity(0.9),
              child: ListTile(
                title: const Text('새 일정을 등록할까요?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text('오늘 오후 7시, 강남역 술약속', style: TextStyle(color: Colors.white70)),
                trailing: TextButton(
                  onPressed: () {}, // 캘린더 등록 로직 연결 [cite: 29]
                  child: const Text('승인', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}