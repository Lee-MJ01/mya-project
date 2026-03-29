import 'package:flutter/material.dart';
import 'package:mya_project/core/constants.dart'; // kActionOrange 사용을 위해 필요

class AlarmStackWidget extends StatelessWidget {
  const AlarmStackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: Card(
              color: kActionOrange.withOpacity(0.9), // 상수 색상 사용
              child: ListTile(
                title: const Text('새 일정을 등록할까요?',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text('오늘 오후 7시, 강남역 술약속',
                    style: TextStyle(color: Colors.white70)),
                trailing: TextButton(
                  onPressed: () {},
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