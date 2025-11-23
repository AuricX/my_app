import '../models/question.dart';
import '../models/category.dart';
import '../models/level.dart';

final List<Question> allQuestions = [
  // General - A1
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'أنا أدرس اللغة الإنجليزية كل يوم.',
    targetGap: 'I study ____ every day.',
    answer: 'English',
    options: ['Arabic', 'English', 'math', 'French'],
    category: QuizCategory.school,
    level: QuizLevel.a1,
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'هو يعيش بالقرب من الجامعة.',
    targetGap: 'He lives ____ the university.',
    answer: 'near',
    options: ['near', 'behind', 'under', 'above'],
    category: QuizCategory.general,
    level: QuizLevel.a1,
  ),
  
  // Transportation - A1
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'السيارة سريعة جداً.',
    targetGap: 'The car is very ____.',
    answer: 'fast',
    options: ['slow', 'fast', 'expensive', 'old'],
    category: QuizCategory.transportation,
    level: QuizLevel.a1,
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الطائرة تطير في السماء.',
    targetGap: 'The airplane flies in the ____.',
    answer: 'sky',
    options: ['sea', 'sky', 'ground', 'forest'],
    category: QuizCategory.transportation,
    level: QuizLevel.a2,
  ),

  // Shopping/Places - A1
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'We are going to the market now.',
    targetGap: 'نحن ذاهبون إلى ____ الآن.',
    answer: 'السوق',
    options: ['البيت', 'السوق', 'المستشفى', 'المدرسة'],
    category: QuizCategory.general,
    level: QuizLevel.a1,
  ),

  // Food & Drinks - A1
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'She drinks tea in the morning.',
    targetGap: 'هي تشرب ____ في الصباح.',
    answer: 'الشاي',
    options: ['الحليب', 'القهوة', 'الماء', 'الشاي'],
    category: QuizCategory.food,
    level: QuizLevel.a1,
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'My mother cooks delicious food.',
    targetGap: 'أمي تطبخ طعاماً ____.',
    answer: 'لذيذاً',
    options: ['لذيذاً', 'حاراً', 'بارداً', 'مالحاً'],
    category: QuizCategory.food,
    level: QuizLevel.a2,
  ),

  // Weather - A1
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الطقس جميل اليوم.',
    targetGap: 'The weather is ____ today.',
    answer: 'nice',
    options: ['cold', 'hot', 'nice', 'rainy'],
    category: QuizCategory.weather,
    level: QuizLevel.a1,
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الحديقة جميلة في الربيع.',
    targetGap: 'The garden is ____ in spring.',
    answer: 'beautiful',
    options: ['dry', 'beautiful', 'cold', 'wet'],
    category: QuizCategory.weather,
    level: QuizLevel.a2,
  ),

  // School - A1
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'He is reading a book.',
    targetGap: 'هو يقرأ ____.',
    answer: 'كتاب',
    options: ['جريدة', 'كتاب', 'قصة', 'مقالة'],
    category: QuizCategory.school,
    level: QuizLevel.a1,
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الولد يذهب إلى المدرسة كل صباح.',
    targetGap: 'The boy goes to ____ every morning.',
    answer: 'school',
    options: ['work', 'school', 'home', 'park'],
    category: QuizCategory.school,
    level: QuizLevel.a1,
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'She writes with a pen.',
    targetGap: 'هي تكتب بـ ____.',
    answer: 'قلم',
    options: ['قلم', 'ورقة', 'كتاب', 'ممحاة'],
    category: QuizCategory.school,
    level: QuizLevel.a1,
  ),

  // Activities/Sports - A1
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'They are playing football.',
    targetGap: 'هم يلعبون ____.',
    answer: 'كرة القدم',
    options: ['كرة السلة', 'كرة القدم', 'تنس', 'سباحة'],
    category: QuizCategory.conversation,
    level: QuizLevel.a1,
  ),

  // Time/Nature - A1
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'The sun rises in the east.',
    targetGap: 'تشرق الشمس في ____.',
    answer: 'الشرق',
    options: ['الغرب', 'الشرق', 'الشمال', 'الجنوب'],
    category: QuizCategory.general,
    level: QuizLevel.a2,
  ),

  // Animals - A1
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'القط يأكل السمك.',
    targetGap: 'The cat eats ____.',
    answer: 'fish',
    options: ['meat', 'fish', 'bread', 'cheese'],
    category: QuizCategory.animals,
    level: QuizLevel.a1,
  ),
];

// Helper methods to filter questions
List<Question> getQuestionsByCategory(QuizCategory category) {
  return allQuestions.where((q) => q.category == category).toList();
}

List<Question> getQuestionsByLevel(QuizLevel level) {
  return allQuestions.where((q) => q.level == level).toList();
}

List<Question> getQuestionsByCategoryAndLevel(
  QuizCategory category,
  QuizLevel level,
) {
  return allQuestions
      .where((q) => q.category == category && q.level == level)
      .toList();
}
