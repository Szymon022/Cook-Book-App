import 'package:cook_book_app/storage/entity/recipe.dart';
import 'package:hive_flutter/adapters.dart';

class CookBookHive {
  static const String recipesBoxName = 'recipesBox';

  static Box get recipesBox => Hive.box(recipesBoxName);

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RecipeAdapter());
    await Hive.openBox(recipesBoxName);
  }
}
