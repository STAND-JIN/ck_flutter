import 'package:flutter/material.dart';

class OnboardingPage3Content extends StatelessWidget {
  final List<String> selectedKeywords; // 선택된 키워드
  final void Function(List<String>) onUpdate; // 업데이트 콜백

  const OnboardingPage3Content({
    Key? key,
    required this.selectedKeywords,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> keywords = [
      "창의성",
      "감정",
      "호기심",
      "친절함",
      "외향성",
      "부끄럼",
      "경청",
      "유연성",
      "낙천적",
      "고독",
      "논리적",
      "겸손함",
      "독서",
      "학습",
      "운동",
      "색감",
      "계획성",
      "도움",
      "몰입",
      "배려심",
      "자율성",
      "산만함",
      "감각",
      "집중력",
      "개성",
      "시간",
      "관찰력",
      "협력",
      "독립심",
      "갈등 회피",
      "대화",
      "예술적",
      "정리정돈",
      "신뢰",
      "활발함",
      "고집",
      "연결성",
      "음악",
      "솔직함",
      "취미",
      "자상함",
      "가족애",
      "사교성",
      "경쟁심",
      "표현력",
      "수용성",
      "개방성",
      "웃음",
      "탐험",
      "끈기",
      "미래 지향",
      "목표",
      "신중함",
      "정직성"
    ];

    final double availableWidth =
        MediaQuery.of(context).size.width - 60; // 좌우 여백
    final int buttonsPerPage = 18;

    final List<List<String>> pages = List.generate(
      (keywords.length / buttonsPerPage).ceil(),
      (index) {
        final start = index * buttonsPerPage;
        final end = (start + buttonsPerPage > keywords.length)
            ? keywords.length
            : start + buttonsPerPage;
        return keywords.sublist(start, end);
      },
    );

    return StatefulBuilder(
      builder: (context, setState) {
        int currentPage = 0; // 현재 페이지

        return Column(
          children: [
            // 키워드 버튼 목록
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index; // 페이지 변경 시 dot indicator 갱신
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: _buildButtonRows(
                      pages[index],
                      availableWidth,
                      selectedKeywords,
                      onUpdate,
                      setState,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // 버튼과 dot indicator 사이 간격 조정
            // Dot indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 20 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: currentPage == index
                        ? const Color(0xff2AB263)
                        : const Color(0xffDBDBDB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildButtonRows(
    List<String> pageKeywords,
    double availableWidth,
    List<String> selectedKeywords,
    void Function(List<String>) onUpdate,
    void Function(void Function()) setState,
  ) {
    return List.generate(
      (pageKeywords.length / 3).ceil(),
      (index) {
        final rowKeywords = pageKeywords.sublist(
          index * 3,
          (index + 1) * 3 > pageKeywords.length
              ? pageKeywords.length
              : (index + 1) * 3,
        );

        final totalLength =
            rowKeywords.fold<int>(0, (sum, trait) => sum + trait.length);

        return Row(
          children: rowKeywords.map((trait) {
            final buttonWidth =
                (trait.length / totalLength) * availableWidth * 0.9;
            final isSelected = selectedKeywords.contains(trait);

            return Container(
              width: buttonWidth,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(buttonWidth, 44), // 버튼 최소 높이 조정
                  backgroundColor:
                      isSelected ? const Color(0xffEBFFF4) : Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xff2AB263)
                          : Color(0xffBBBBBB),
                    ),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedKeywords.remove(trait); // 제거
                    } else if (selectedKeywords.length < 3) {
                      selectedKeywords.add(trait); // 추가
                    }
                    onUpdate(
                        List<String>.from(selectedKeywords)); // 선택된 키워드 배열 업데이트
                  });
                },
                child: Text(
                  trait,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
