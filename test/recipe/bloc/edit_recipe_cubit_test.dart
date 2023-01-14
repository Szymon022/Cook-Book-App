import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/navigation/router_state.dart';
import 'package:cook_book_app/recipe/bloc/edit_recipe_cubit.dart';
import 'package:cook_book_app/recipe/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';

class MockRouterCubit extends MockCubit<RouterState> implements RouterCubit {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  Recipe recipe = const Recipe('Recipe 1', '10 min', '300 kcals');
  MockRouterCubit routerCubit = MockRouterCubit();

  blocTest('calls RouterCubit popExtra on goBack method',
      build: () => EditRecipeCubit(routerCubit, recipe),
      act: (cubit) => cubit.goBack(),
      verify: (_) {
        verify(() => routerCubit.popExtra()).called(1);
      });

  blocTest('calls RouterCubit popExtra on saveRecipe method',
      build: () => EditRecipeCubit(routerCubit, recipe),
      act: (cubit) => cubit.saveRecipe(recipe),
      verify: (_) {
        verify(() => routerCubit.popExtra()).called(1);
      });
}
