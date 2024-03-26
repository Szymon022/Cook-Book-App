import 'package:cook_book_app/storage/cook_book_hive.dart';

import 'entity/recipe.dart';

abstract class RecipeRepository {
  List<Recipe> getAllRecipes([String? query]);

  void saveRecipe(Recipe recipe);

  void updateRecipe(String uuid, Recipe recipe);

  void deleteRecipe(String uuid);
}

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  List<Recipe> getAllRecipes([String? query]) {
    List<Recipe> recipes =
        CookBookHive.recipesBox.values.toList().cast<Recipe>();
    if (query != null) {
      return recipes.mapNotNull((recipe) {
        if (recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.description.toLowerCase().contains(query.toLowerCase())) {
          return recipe;
        }
        return null;
      });
    }
    return recipes;
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

extension Mappings on Iterable<Recipe> {
  List<Recipe> mapNotNull(Recipe? Function(Recipe) transform) {
    List<Recipe> result = [];
    forEach((element) {
      Recipe? recipe = transform(element);
      if (recipe != null) result.add(recipe);
    });
    return result;
  }
}
