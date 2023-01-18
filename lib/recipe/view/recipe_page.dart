import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_page_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/entity/recipe.dart';

class RecipePage extends StatelessWidget {
  const RecipePage(this.recipe, {Key? key}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    RouterCubit routerCubit = context.read<RouterCubit>();
    return BlocProvider(
      create: (context) => RecipeCubit(routerCubit, recipe),
      child: BlocBuilder<RecipeCubit, RecipePageViewState>(
        builder: (context, state) => Scaffold(
          appBar: _appBar(context),
          body: _content(state),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    var cubit = context.read<RecipeCubit>();
    return AppBar(
      leading: IconButton(
        onPressed: cubit.goBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {
            cubit.editRecipe();
          },
          icon: const Icon(Icons.edit_note),
        ),
      ],
    );
  }

  Widget _content(RecipePageViewState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipePhoto(),
          _recipeInformation(state),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _recipePhoto() {
    const String burger =
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80';

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: const Image(
          image: NetworkImage(burger),
          height: 300,
        ),
      ),
    );
  }

  Widget _recipeInformation(RecipePageViewState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            state.recipeName,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 36),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.preparationTime, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              Text(state.energy, style: const TextStyle(fontSize: 24))
            ],
          ),
        ],
      ),
    );
  }
}
