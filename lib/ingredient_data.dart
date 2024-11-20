// ingredient_data.dart

// 영어 이름과 한국어 이름의 매핑
final Map<String, String> ingredientData = {
  "bread": "빵",
  "onion": "양파",
  "cheese": "치즈",
  "mayonnaise": "마요네즈",
  "beef_patty": "소고기 패티",
  "lettuce": "양상추",
  "shrimp_patty": "새우 패티",
  "pork_patty": "돼지고기 패티",
  "tomato": "토마토",
  "pickle": "피클",
  "ketchup": "케첩",
  "special_sauce": "특별한 소스",
  "hash_brown": "해쉬 브라운",
};

// 영어 이름 리스트 (재료 키값만 사용)
final List<String> ingredientKeys = ingredientData.keys.toList();
