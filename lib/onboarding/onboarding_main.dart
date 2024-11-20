import 'package:flutter/material.dart';
import 'onboarding_page_2.dart'; // 2페이지 내용
import 'onboarding_page_3.dart'; // 3페이지 내용

class OnboardingMain extends StatefulWidget {
  final int initialPage; // 초기 페이지 (2 또는 3)

  const OnboardingMain({Key? key, this.initialPage = 2}) : super(key: key);

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  late int currentPage;

  // 2페이지의 유효성 검사 및 경고 로직
  bool _validatePage2(String? name, String? gender, String? birth) {
    return name != null &&
        name.trim().isNotEmpty &&
        gender != null &&
        birth != null &&
        birth.trim().length == 8;
  }

  // 3페이지의 유효성 검사 로직
  bool _validatePage3(List<String> selectedKeywords) {
    return selectedKeywords.length == 3;
  }

  // 경고 메시지 표시
  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("입력 오류"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage; // 초기 페이지 설정
  }

  @override
  Widget build(BuildContext context) {
    String? name;
    String? gender;
    String? birth;
    List<String> selectedKeywords = [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 150), // 상단 여백
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 공통 헤더 텍스트
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: currentPage == 2 ? '아이의 ' : '아이의 ',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: currentPage == 2 ? '정보' : '성향',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: currentPage == 2 ? '를\n' : '을\n',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: currentPage == 2
                                ? '입력해주세요'
                                : '3가지 골라주세요. (${selectedKeywords.length}/3)',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 50), // 헤더와 중간 컨텐츠 간 여백
                  // 중간 내용 (2페이지 또는 3페이지)
                  Expanded(
                    child: currentPage == 2
                        ? OnboardingPage2Content(
                            onUpdate:
                                (updatedName, updatedGender, updatedBirth) {
                              name = updatedName;
                              gender = updatedGender;
                              birth = updatedBirth;
                            },
                          )
                        : OnboardingPage3Content(
                            selectedKeywords: selectedKeywords,
                            onUpdate: (updatedKeywords) {
                              selectedKeywords = updatedKeywords;
                            },
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50), // 중간 컨텐츠와 버튼 간 여백
            // 공통 하단 버튼
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffA3A3A3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (currentPage == 2) {
                          Navigator.pop(context);
                        } else if (currentPage == 3) {
                          setState(() {
                            currentPage = 2; // 2페이지로 돌아가기
                          });
                        }
                      },
                      child: const Text(
                        '이전',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2AB263),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (currentPage == 2) {
                          if (_validatePage2(name, gender, birth)) {
                            setState(() {
                              currentPage = 3; // 3페이지로 이동
                            });
                          } else {
                            _showAlert("모든 항목을 올바르게 입력해주세요.");
                          }
                        } else if (currentPage == 3) {
                          if (_validatePage3(selectedKeywords)) {
                            print('선택된 성향 : $selectedKeywords');
                          } else {
                            _showAlert("성향을 3가지 선택해주세요.");
                          }
                        }
                      },
                      child: Text(
                        currentPage == 2 ? '다음' : '생성',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 150), // 하단 여백
          ],
        ),
      ),
    );
  }
}
