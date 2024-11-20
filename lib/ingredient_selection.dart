import 'package:ck_flutter/ingredient_data.dart';
import 'package:ck_flutter/ingredient_review.dart';
import 'package:flutter/material.dart';

class IngredientSelectionPage extends StatefulWidget {
  const IngredientSelectionPage({Key? key}) : super(key: key);

  @override
  State<IngredientSelectionPage> createState() =>
      _IngredientSelectionPageState();
}

class _IngredientSelectionPageState extends State<IngredientSelectionPage> {
  final List<String> selectedIngredients = [];
  final Map<String, int> ingredientCounts = {};
  int currentPage = 0;
  final int buttonsPerPage = 12;
  final Color selectedColor = const Color(0xff2AB263);
  final Color whiteColor = const Color(0xffFFFFFF);

  void resetSelection() {
    setState(() {
      selectedIngredients.clear();
      ingredientCounts.clear();
    });
  }

  void selectIngredient(String ingredient) {
    setState(() {
      selectedIngredients.add(ingredient);
      ingredientCounts[ingredient] = (ingredientCounts[ingredient] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 100;

    final totalPages = (ingredientKeys.length / buttonsPerPage).ceil();
    final pages = List.generate(totalPages, (pageIndex) {
      final start = pageIndex * buttonsPerPage;
      final end = (start + buttonsPerPage) < ingredientKeys.length
          ? start + buttonsPerPage
          : ingredientKeys.length;
      return ingredientKeys.sublist(start, end);
    });

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          '재료를 골라보자!',
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: List.generate(selectedIngredients.length, (index) {
                  final ingredient = selectedIngredients[index];
                  return Positioned(
                    bottom: index * 10.0,
                    child: Image.asset(
                      'assets/images/$ingredient.png',
                      width: 100,
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/base.jpg',
                          width: 100,
                          height: 100,
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: resetSelection,
                  child: Image.asset(
                    'assets/images/refresh_circle.png',
                    width: 35,
                    height: 35,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children:
                        _buildButtonRows(pages[index], availableWidth * 0.9),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 20 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: currentPage == index
                        ? selectedColor
                        : const Color(0xffDBDBDB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45, bottom: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedColor,
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: selectedIngredients.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IngredientReviewPage(
                            selectedIngredients: selectedIngredients,
                          ),
                        ),
                      );
                      print('선택한 재료 : $selectedIngredients');
                    }
                  : null,
              child: const Text(
                '완료',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtonRows(
      List<String> pageIngredients, double availableWidth) {
    List<Widget> rows = [];
    for (int i = 0; i < pageIngredients.length; i += 3) {
      final rowIngredients = pageIngredients.sublist(
          i, i + 3 > pageIngredients.length ? pageIngredients.length : i + 3);
      rows.add(_buildButtonRow(rowIngredients, availableWidth));
    }
    return rows;
  }

  Widget _buildButtonRow(List<String> ingredients, double availableWidth) {
    final totalLength = ingredients.fold<int>(
        0, (sum, ingredient) => sum + ingredientData[ingredient]!.length);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ingredients.map((ingredient) {
        final buttonWidth =
            (ingredientData[ingredient]!.length / totalLength) * availableWidth;
        final count = ingredientCounts[ingredient] ?? 0;
        final isSelected = ingredientCounts[ingredient] != null;

        return Container(
          width: buttonWidth + 15,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Stack(
            children: [
              InkWell(
                onTap: () => selectIngredient(ingredient),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xffEBFFF4) : whiteColor,
                    border: Border.all(
                      color: isSelected ? selectedColor : Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    ingredientData[ingredient]!, // 한국어 이름 표시
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (count > 1)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffEBFFF4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'X$count',
                      style: const TextStyle(
                        fontSize: 12,
                        color: const Color(0xff94D8B0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
