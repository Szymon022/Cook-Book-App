import 'package:bloc/bloc.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/recipe.dart';

import 'home_page_view_state.dart';

class HomePageCubit extends Cubit<HomePageViewState> {
  HomePageCubit(this._routerCubit) : super(const HomePageViewState([]));

  final RouterCubit _routerCubit;

  void goToRecipe(Recipe recipe) => _routerCubit.navigateToRecipe(recipe);

  void createNewRecipe() => _routerCubit.navigateToEditRecipe();

  void editRecipe(Recipe recipe) => _routerCubit.navigateToEditRecipe(recipe);
}
