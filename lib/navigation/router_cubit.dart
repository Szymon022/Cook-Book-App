import 'package:bloc/bloc.dart';
import 'package:cook_book_app/navigation/router_state.dart';

import '../storage/entity/recipe.dart';

class RouterCubit extends Cubit<RouterState> {
  RouterCubit() : super(const HomePageState());

  void navigateToHome() {
    emit(const HomePageState());
  }

  void navigateToEditRecipe([Recipe? recipe]) {
    emit(EditRecipePageState(recipe));
  }

  void navigateToRecipe(Recipe recipe) {
    emit(RecipePageState(recipe));
  }

  void popExtra() {
    navigateToHome();
  }
}
