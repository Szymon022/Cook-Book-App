import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/entity/recipe.dart';
import 'edit_recipe_view_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeViewState> {
  EditRecipeCubit(RouterCubit routerCubit, RecipeRepository recipeRepository,
      Recipe? recipe)
      : _routerCubit = routerCubit,
        _recipeRepository = recipeRepository,
        super(EditRecipeViewState(recipe));

  final RouterCubit _routerCubit;
  final RecipeRepository _recipeRepository;

  void saveRecipe(Recipe recipe) {
    // save recipe here
    _recipeRepository.saveRecipe(recipe);
    _routerCubit.popExtra();
  }

  void goBack() => _routerCubit.popExtra();
}
