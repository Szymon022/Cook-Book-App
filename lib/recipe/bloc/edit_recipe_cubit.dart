import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/entity/recipe.dart';
import 'edit_recipe_view_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeViewState> {
  EditRecipeCubit(RouterCubit routerCubit, Recipe? recipe)
      : _routerCubit = routerCubit,
        super(EditRecipeViewState(recipe));

  final RouterCubit _routerCubit;

  void saveRecipe(Recipe recipe) {
    // save recipe here
    _routerCubit.popExtra();
  }

  void goBack() => _routerCubit.popExtra();
}
