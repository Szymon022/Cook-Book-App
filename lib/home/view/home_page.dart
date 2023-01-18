import 'package:cook_book_app/home/bloc/home_page_cubit.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/entity/recipe.dart';
import '../bloc/home_page_view_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RouterCubit routerCubit = context.read<RouterCubit>();
    final RecipeRepository recipeRepository = RecipeRepositoryImpl();
    return BlocProvider(
      create: (context) => HomePageCubit(routerCubit, recipeRepository),
      child: BlocBuilder<HomePageCubit, HomePageViewState>(
        builder: (context, state) => Scaffold(
          appBar: _homeAppBar(),
          body: Column(
            children: [
              _homeContent(state.recipes),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<HomePageCubit>().createNewRecipe(),
          ),
        ),
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar();
  }

  Widget _homeContent(List<Recipe> recipes) {
    return Expanded(
      child: ListView.builder(
        itemCount: recipes.length + 1,
        itemBuilder: (context, index) {
          if (index == recipes.length) {
            return const SizedBox(height: 80);
          } else {
            Recipe recipe = recipes[index];
            return _RecipeItem(
              recipe: recipe,
              onRecipeTap: () =>
                  context.read<HomePageCubit>().goToRecipe(recipe),
            );
          }
        },
      ),
    );
  }
}

class _RecipeItem extends StatelessWidget {
  const _RecipeItem({required this.recipe, required this.onRecipeTap});

  final Recipe recipe;
  final void Function() onRecipeTap;
  final String burger =
      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRecipeTap,
      child: Center(
        child: Card(
          elevation: 4,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _recipePhoto(),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: _recipeHeader(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recipePhoto() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      child: Image(
        image: NetworkImage(burger),
        height: 300,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _recipeHeader() {
    return Column(
      children: [
        _recipeTitleRow(),
        const SizedBox(height: 4),
        _recipeTagsRow(),
      ],
    );
  }

  Widget _recipeTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _recipeTitle(recipe.name),
        _timeIndicator(recipe.time),
      ],
    );
  }

  Widget _recipeTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
    );
  }

  Widget _timeIndicator(String time) {
    return Row(
      children: [
        const Icon(Icons.timer),
        const SizedBox(width: 4),
        Text(time),
      ],
    );
  }

  Widget _recipeTagsRow() {
    return Row(
      children: const [
        Text('Dinner'),
        SizedBox(width: 4),
        Text('Lunch'),
      ],
    );
  }
}
