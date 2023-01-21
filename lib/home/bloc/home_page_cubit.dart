import 'package:bloc/bloc.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/entity/recipe.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_view_state.dart';

class HomePageCubit extends Cubit<HomePageViewState> {
  HomePageCubit(RouterCubit routerCubit, RecipeRepository recipeRepository)
      : _routerCubit = routerCubit,
        _recipeRepository = recipeRepository,
        super(HomePageViewState(recipeRepository.getAllRecipes()));

  final RouterCubit _routerCubit;
  final RecipeRepository _recipeRepository;

  void goToRecipe(Recipe recipe) => _routerCubit.navigateToRecipe(recipe);

  void createNewRecipe() => _routerCubit.navigateToEditRecipe();

  void editRecipe(Recipe recipe) => _routerCubit.navigateToEditRecipe(recipe);

  void loadRecipes([String? query]) {
    final List<Recipe> recipes = _recipeRepository.getAllRecipes(query);
    emit(HomePageViewState(recipes));
  }
}
