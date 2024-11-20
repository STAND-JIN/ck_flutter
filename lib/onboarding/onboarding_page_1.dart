import 'package:flutter/material.dart';
import 'onboarding_main.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 로고 이미지
            Image.asset(
              'assets/images/logo_1.png',
              width: 250,
              height: 100,
            ),
            const SizedBox(height: 100),
            // 설명 텍스트
            const Text(
              '쿡힘마마가 처음이신가요?\n우리 아이의 첫 캐릭터를 만들어 볼까요?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 30),
            // 시작 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingMain(
                      initialPage: 2, // 초기 페이지 설정
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2AB263), // 버튼 색상
                minimumSize: const Size(200, 45), // 버튼 크기
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // 둥근 모서리
                ),
                elevation: 0, // 그림자 제거
              ),
              child: const Text(
                '시작',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
