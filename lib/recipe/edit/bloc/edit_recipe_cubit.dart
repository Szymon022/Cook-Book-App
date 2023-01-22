import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../storage/entity/recipe.dart';
import 'edit_recipe_view_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeViewState> {
  EditRecipeCubit(this._routerCubit, this._recipeRepository)
      : super(ShouldNotShowCamera());

  final RouterCubit _routerCubit;
  final RecipeRepository _recipeRepository;

  void saveRecipe(Recipe recipe) {
    _recipeRepository.saveRecipe(recipe);
    goBack();
  }

  void updateRecipe(Recipe recipe) {
    _recipeRepository.updateRecipe(recipe.uuid, recipe);
    goBack();
  }

  void onTakingPictureStarted() {
    emit(ShouldShowCamera());
  }

  void onTakingPictureFinished() {
    emit(ShouldNotShowCamera());
  }

  void goBack() {
    onTakingPictureFinished();
    _routerCubit.popExtra();
  }
}
