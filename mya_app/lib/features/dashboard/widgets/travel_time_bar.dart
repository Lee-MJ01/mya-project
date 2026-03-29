import 'package:flutter/material.dart';
import 'package:mya_project/core/constants.dart'; // kActionOrange 사용을 위해 필요

class TravelTimeBar extends StatelessWidget {
  final int prepMinutes; // 개인 준비 시간 [cite: 12]
  final int transitMinutes; // 대중교통 이동 시간

  const TravelTimeBar({required this.prepMinutes, required this.transitMinutes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 개인 준비 시간 블록 (Mint)
        Container(
          height: prepMinutes * 2.0, // 분당 2px로 가변 높이 설정
          decoration: BoxDecoration(
            color: kSmartMint.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(child: Icon(Icons.accessibility_new, color: kSmartMint, size: 16)),
        ),
        // 대중교통 이동 블록 (Navy)
        Container(
          height: transitMinutes * 2.0,
          color: kTrustNavy.withOpacity(0.1),
          child: const Center(child: Icon(Icons.directions_bus, color: kTrustNavy, size: 16)),
        ),
      ],
    );
  }
}