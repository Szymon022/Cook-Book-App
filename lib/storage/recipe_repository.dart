import 'package:cook_book_app/storage/cook_book_hive.dart';

import 'entity/recipe.dart';

abstract class RecipeRepository {
  List<Recipe> getAllRecipes();

  void saveRecipe(Recipe recipe);

  void deleteRecipe(Recipe recipe);
}

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  void deleteRecipe(Recipe recipe) {
    CookBookHive.recipesBox.delete(recipe.name);
  }

  @override
  List<Recipe> getAllRecipes() {
    return CookBookHive.recipesBox.values.toList().cast<Recipe>();
  }

  @override
  void saveRecipe(Recipe recipe) {
    CookBookHive.recipesBox.put(recipe.name, recipe);
  }
}
