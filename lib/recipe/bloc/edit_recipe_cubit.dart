import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../recipe.dart';
import 'edit_recipe_view_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeViewState> {
  EditRecipeCubit(BuildContext context, Recipe? recipe)
      : _routerCubit = context.read<RouterCubit>(),
        super(EditRecipeViewState(recipe));

  final RouterCubit _routerCubit;

  void saveRecipe(Recipe recipe) {
    // save recipe here
    _routerCubit.popExtra();
  }

  void goBack() => _routerCubit.popExtra();
}
