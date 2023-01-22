import 'package:bloc/bloc.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/details/bloc/recipe_details_view_state.dart';
import 'package:cook_book_app/storage/files/file_eradicator.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';

import '../../../storage/entity/recipe.dart';

class RecipeDetailsCubit extends Cubit<RecipeDetailsViewState> {
  RecipeDetailsCubit(this.routerCubit, this.recipeRepository,
      this.fileEradicator, Recipe recipe)
      : super(RecipeDetailsViewState(recipe));

  final RouterCubit routerCubit;
  final RecipeRepository recipeRepository;
  final FileEradicator fileEradicator;

  void editRecipe() => routerCubit.navigateToEditRecipe(state.recipe);

  void deleteRecipe() {
    fileEradicator.eradicate(state.imagePath);
    recipeRepository.deleteRecipe(state.uuid);
    goBack();
  }

  void goBack() => routerCubit.popExtra();
}
