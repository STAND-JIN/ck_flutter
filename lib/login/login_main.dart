import 'package:ck_flutter/onboarding/onboarding_page_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get _isFormValid =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool _passwordVisible = false;
  bool _showErrorMessage = false; // 에러 메시지 표시 여부

  void _handleLogin() {
    if (_emailController.text == 'aaa' && _passwordController.text == '1234') {
      // 로그인 성공
      setState(() {
        _showErrorMessage = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingPage1(),
        ),
      );
    } else {
      // 로그인 실패
      setState(() {
        _showErrorMessage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton(
              onPressed: () {
                print('언어 변경');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Row(
                children: [
                  Text(
                    'Korea, 한국어',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                'assets/images/lg_logo.svg',
                width: 150,
                height: 50,
              ),
            ),
            const SizedBox(height: 40),
            // 이메일 입력 필드
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이메일 아이디 또는 휴대폰 번호 아이디',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextField(
              controller: _emailController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD9D9D9)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 비밀번호 입력 필드
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextField(
              controller: _passwordController,
              onChanged: (value) => setState(() {}),
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD9D9D9)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD9D9D9)),
                ),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/show.svg', // 비밀번호 보기 아이콘
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 5), // 줄인 여백
            if (_showErrorMessage)
              const Padding(
                padding: EdgeInsets.only(bottom: 7), // 버튼 위 여백
                child: Text(
                  '아이디 또는 비밀번호를 잘못 입력하셨습니다.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: _isFormValid ? _handleLogin : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid
                    ? const Color(0xffA40033)
                    : const Color(0xffEDEDED),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '로그인',
                style: TextStyle(
                  color: _isFormValid
                      ? const Color(0xffFFFFFF)
                      : const Color(0xffB8B8B8),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5), // 줄인 여백
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '아이디 찾기',
                    style: TextStyle(color: Color(0xff8C8C8C), fontSize: 13),
                  ),
                ),
                const Text('|',
                    style: TextStyle(color: Color(0xffE1E1E1), fontSize: 13)),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '비밀번호 재설정',
                    style: TextStyle(color: Color(0xff8C8C8C), fontSize: 13),
                  ),
                ),
                const Text('|',
                    style: TextStyle(color: Color(0xffE1E1E1), fontSize: 13)),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '회원가입',
                    style: TextStyle(color: Color(0xff525252), fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            const Divider(
              color: Color(0xffE1E1E1),
              thickness: 1,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('MY LG ID 로그인');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xffA40033)),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'MY ',
                      style: TextStyle(
                        color: Color(0xffB8B8B8),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'LG ID ',
                      style: TextStyle(
                        color: Color(0xff9B536E),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: '로그인',
                      style: TextStyle(
                        color: Color(0xffBB6B87),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            SvgPicture.asset(
              'assets/images/other_login.svg',
              width: 200,
              height: 70,
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '다른 계정으로 로그인',
                  style: TextStyle(
                      color: Color(0xff9F9F9F),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 10),
                Icon(Icons.navigate_next, color: Color(0xff9F9F9F)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
