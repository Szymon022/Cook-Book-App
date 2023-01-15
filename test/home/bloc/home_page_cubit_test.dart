import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/home/bloc/home_page_cubit.dart';
import 'package:cook_book_app/home/bloc/home_page_view_state.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/recipe.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_router_cubit.dart';

void main() {
  Recipe recipe = const Recipe("Recipe 1", '30 min', '100 kcal');
  RouterCubit routerCubit = MockRouterCubit();

  blocTest(
    'calls RouterCubit navigateToRecipe on goToRecipe',
    build: () => HomePageCubit(routerCubit),
    act: (cubit) => cubit.goToRecipe(recipe),
    expect: () => [],
    verify: (_) => verify(() => routerCubit.navigateToRecipe(recipe)).called(1),
  );

  blocTest(
    'calls RouterCubit navigateToEditRecipe on createNewRecipe',
    build: () => HomePageCubit(routerCubit),
    act: (cubit) => cubit.createNewRecipe(),
    expect: () => [],
    verify: (_) => verify(() => routerCubit.navigateToEditRecipe()).called(1),
  );

  blocTest(
    'calls RouterCubit navigateToEditRecipe on editRecipe',
    build: () => HomePageCubit(routerCubit),
    act: (cubit) => cubit.editRecipe(recipe),
    expect: () => [],
    verify: (_) =>
        verify(() => routerCubit.navigateToEditRecipe(recipe)).called(1),
  );

  blocTest(
    'sets HomePageViewState([]) as initial state',
    build: () => HomePageCubit(routerCubit),
    expect: () => [],
    verify: (cubit) => {cubit.state == const HomePageViewState([])},
  );
}
