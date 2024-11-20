import 'package:flutter/material.dart';

class OnboardingPage2Content extends StatefulWidget {
  final void Function(String? name, String? gender, String? birth) onUpdate;

  const OnboardingPage2Content({Key? key, required this.onUpdate})
      : super(key: key);

  @override
  State<OnboardingPage2Content> createState() => _OnboardingPage2ContentState();
}

class _OnboardingPage2ContentState extends State<OnboardingPage2Content> {
  String? _selectedGender; // 선택된 성별 값
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  // 성별 선택 시 상태를 업데이트하고 부모에게 알림
  void _updateGender(String gender) {
    setState(() {
      _selectedGender = gender;
      print(_selectedGender);
    });
    widget.onUpdate(
        _nameController.text, _selectedGender, _birthController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 이름 입력
        const Text(
          '이름',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          onChanged: (value) {
            widget.onUpdate(value, _selectedGender, _birthController.text);
          },
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFFEDEDED),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: '홍길동',
            hintStyle: TextStyle(color: Color(0xffB8B8B8)),
          ),
        ),
        const SizedBox(height: 35),
        // 성별 선택
        const Text(
          '성별',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () => _updateGender('남자'),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _selectedGender == '남자'
                          ? const Color(0xff898989)
                          : const Color(0xffEDEDED),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text('남자'),
                ],
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => _updateGender('여자'),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _selectedGender == '여자'
                          ? const Color(0xff898989)
                          : const Color(0xffEDEDED),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text('여자'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 35),
        // 생년월일 입력
        const Text(
          '생년월일',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _birthController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            widget.onUpdate(_nameController.text, _selectedGender, value);
          },
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFFEDEDED),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: '숫자 8자리',
            hintStyle: TextStyle(color: Color(0xffB8B8B8)),
          ),
        ),
      ],
    );
  }
}
