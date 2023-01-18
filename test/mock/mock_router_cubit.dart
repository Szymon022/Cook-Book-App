import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/navigation/router_state.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRouterCubit extends MockCubit<RouterState> implements RouterCubit {}

class MockRecipeRepository extends Mock implements RecipeRepository {}
