import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/navigation/router_state.dart';
import 'package:flutter/material.dart';

import '../home/view/home_page.dart';
import '../recipe/recipe.dart';
import '../recipe/view/edit_recipe_page.dart';
import '../recipe/view/recipe_page.dart';

class RootRouterDelegate extends RouterDelegate<RouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final RouterCubit _routerCubit;

  RootRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, RouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: List.from([
        _materialPage(valueKey: "homeScreen", child: HomePage()),
        ..._extraPages
      ]),
      onPopPage: _onPopPageParser,
    );
  }

  @override
  Future<bool> popRoute() async {
    if (_extraPages.isNotEmpty) {
      _routerCubit.popExtra();
      return true;
    }
    if (_routerCubit.state is! HomePageState) {
      _routerCubit.navigateToHome();
      return true;
    }
    return true;
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(RouterState configuration) async {}

  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
  }

  Page _materialPage({required String valueKey, required Widget child}) {
    return MaterialPage(
      key: ValueKey<String>(valueKey),
      child: child,
    );
  }

  List<Page> get _extraPages {
    Recipe? recipe;
    if (_routerCubit.state is RecipePageState) {
      recipe = (_routerCubit.state as RecipePageState).recipe;
      return [
        _materialPage(
          valueKey: "recipePage",
          child: RecipePage(recipe),
        ),
      ];
    }

    if (_routerCubit.state is EditRecipePageState) {
      recipe = (_routerCubit.state as EditRecipePageState).recipe;
      return [
        _materialPage(
          valueKey: "editRecipePage",
          child: EditRecipePage(recipe: recipe),
        ),
      ];
    }

    return [];
  }
}
