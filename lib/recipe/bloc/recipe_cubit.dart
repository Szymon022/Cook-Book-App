import 'package:bloc/bloc.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_page_view_state.dart';

import '../../storage/entity/recipe.dart';

class RecipeCubit extends Cubit<RecipePageViewState> {
  RecipeCubit(this.routerCubit, Recipe recipe)
      : super(RecipePageViewState(recipe));

  final RouterCubit routerCubit;

  void editRecipe() => routerCubit.navigateToEditRecipe(state.recipe);

  void goBack() => routerCubit.popExtra();
}
