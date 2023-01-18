import 'package:bloc/bloc.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/entity/recipe.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_view_state.dart';

class HomePageCubit extends Cubit<HomePageViewState> {
  HomePageCubit(RouterCubit routerCubit)
      : _routerCubit = routerCubit,
        super(const HomePageViewState([]));

  final RouterCubit _routerCubit;

  void goToRecipe(Recipe recipe) => _routerCubit.navigateToRecipe(recipe);

  void createNewRecipe() => _routerCubit.navigateToEditRecipe();

  void editRecipe(Recipe recipe) => _routerCubit.navigateToEditRecipe(recipe);
}
