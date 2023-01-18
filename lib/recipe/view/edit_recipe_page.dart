import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/view/text_form.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/entity/recipe.dart';
import '../bloc/edit_recipe_cubit.dart';
import '../bloc/edit_recipe_view_state.dart';

class EditRecipePage extends StatelessWidget {
  EditRecipePage({super.key, this.recipe});

  final Recipe? recipe;
  String _recipeName = "";
  String _preparationTime = "";
  String _energy = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RouterCubit routerCubit = context.read<RouterCubit>();
    return BlocProvider(
      create: (context) =>
          EditRecipeCubit(routerCubit, RecipeRepositoryImpl(), recipe),
      child: BlocBuilder<EditRecipeCubit, EditRecipeViewState>(
        builder: (context, state) => Scaffold(
          appBar: _appBar(context),
          body: _content(),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    var cubit = context.read<EditRecipeCubit>();
    return AppBar(
      leading: IconButton(
        onPressed: cubit.goBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {
            cubit.saveRecipe(Recipe(_recipeName, _preparationTime, _energy));
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _photoPicker(),
          _forms(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _photoPicker() {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.only(bottom: 16),
          height: 300,
          width: double.infinity,
          color: Colors.black,
          child: const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 120,
            ),
          ),
        ),
      ),
    );
  }

  Widget _forms() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _titleForm(),
            const SizedBox(height: 8),
            Row(
              children: [
                _timeForm(),
                const SizedBox(width: 16),
                _energyForm(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _titleForm() {
    return TextForm(
      onChanged: (name) => _recipeName = name,
      hintText: 'Recipe title',
      initialValue: recipe?.name,
    );
  }

  Widget _timeForm() {
    return Expanded(
      child: TextForm(
        onChanged: (preparationTime) => _preparationTime = preparationTime,
        hintText: 'Recipe time',
        initialValue: recipe?.time,
      ),
    );
  }

  Widget _energyForm() {
    return Expanded(
      child: TextForm(
        onChanged: (energy) => _energy = energy,
        hintText: 'Kcals',
        initialValue: recipe?.energy,
      ),
    );
  }
}
