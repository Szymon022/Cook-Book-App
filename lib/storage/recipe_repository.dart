import 'package:cook_book_app/storage/cook_book_hive.dart';

import 'entity/recipe.dart';

abstract class RecipeRepository {
  List<Recipe> getAllRecipes();

  void saveRecipe(Recipe recipe);

  void updateRecipe(String uuid, Recipe recipe);

  void deleteRecipe(String uuid);
}

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  List<Recipe> getAllRecipes() {
    return CookBookHive.recipesBox.values.toList().cast<Recipe>();
  }

  @override
  void saveRecipe(Recipe recipe) {
    CookBookHive.recipesBox.put(recipe.uuid, recipe);
  }

  @override
  void updateRecipe(String uuid, Recipe recipe) {
    CookBookHive.recipesBox.put(uuid, recipe);
  }

  @override
  void deleteRecipe(String uuid) {
    CookBookHive.recipesBox.delete(uuid);
  }
}
