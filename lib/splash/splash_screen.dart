import 'package:ck_flutter/login/login_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showLoginContent = false; // 텍스트와 버튼 표시 여부

  @override
  void initState() {
    super.initState();
    // 3초 후에 텍스트와 버튼 표시
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showLoginContent = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 고정된 로고
            Image.asset(
              'assets/images/logo_1.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 24),
            // 아래 텍스트와 버튼에 애니메이션 적용
            AnimatedOpacity(
              opacity: _showLoginContent ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Column(
                children: [
                  const Text(
                    '쿡힘마마 서비스 이용을 위해\nLG전자 계정으로 로그인 해주세요',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginMain(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffA40033), // 버튼 배경색
                      maximumSize: const Size(200, 50), // 버튼 크기
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // 버튼 둥근 모서리
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5), // 여유 공간
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // 이미지와 텍스트 왼쪽 정렬
                      children: [
                        SvgPicture.asset(
                          'assets/images/lg_logo_w.svg', // LG 로고 이미지
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(width: 20), // 이미지와 텍스트 사이 간격
                        const Text(
                          'LG 계정 로그인',
                          style: TextStyle(
                            color: Colors.white, // 글씨 흰색
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
