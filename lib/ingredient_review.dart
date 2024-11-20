import 'package:flutter/material.dart';
import 'ingredient_data.dart'; // 공통 데이터 파일 import
import 'ingredient_selection.dart'; // 재료 선택 페이지 import

class IngredientReviewPage extends StatelessWidget {
  final List<String> selectedIngredients;

  IngredientReviewPage({
    Key? key,
    required this.selectedIngredients,
  }) : super(key: key);

  final Map<String, int> ingredientCounts = {};

  @override
  Widget build(BuildContext context) {
    _calculateIngredientCounts();

    return Scaffold(
      backgroundColor: Colors.white, // 전체 배경 흰색
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '장바구니',
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0), // 재료 목록 양쪽 여백 50
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              '빠진 재료는 없나요?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: ingredientCounts.length,
                itemBuilder: (context, index) {
                  final englishName = ingredientCounts.keys.elementAt(index);
                  final count = ingredientCounts[englishName]!;
                  final koreanName = ingredientData[englishName] ?? englishName;

                  return _buildIngredientItem(englishName, koreanName, count);
                },
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0), // 버튼 양쪽 여백 60
              child: Row(
                children: [
                  // 취소 버튼
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XffA3A3A3),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // 취소 버튼을 누르면 재료 선택 페이지로 이동
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const IngredientSelectionPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15), // 버튼 간 여백 15
                  // 주문 버튼
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2AB263),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // 주문 버튼 클릭 시 모달 표시
                          _showOrderModal(context);
                          print('주문 완료: $ingredientCounts');
                        },
                        child: const Text(
                          '주문',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // 선택한 재료의 개수를 계산하는 함수
  void _calculateIngredientCounts() {
    for (var ingredient in selectedIngredients) {
      ingredientCounts[ingredient] = (ingredientCounts[ingredient] ?? 0) + 1;
    }
  }

  // 재료 항목을 구성하는 위젯
  Widget _buildIngredientItem(
      String englishName, String koreanName, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 이미지
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              'assets/images/$englishName.png', // 영어 이름으로 이미지 로드
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/base.jpg',
                  width: 80,
                  height: 80,
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // 재료명
          Expanded(
            child: Text(
              koreanName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          // 개수
          Expanded(
            child: Text(
              'X$count',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

// 주문 완료 모달 표시 함수
  void _showOrderModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 모달 밖을 클릭해도 닫히지 않도록 설정
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50), // 아이콘 공간
                    const Text(
                      '주문이 완료되었습니다.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        '배달이 완료될 때까지 시뮬레이션을 진행해주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xff2AB263),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context); // 모달 닫기
                        },
                        child: const Text(
                          '확인',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -50,
                child: Image.asset(
                  'assets/images/select_bucket.png', // 교체된 아이콘
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
