import 'package:cook_book_app/recipe/view/text_form.dart';
import 'package:flutter/material.dart';

class EditRecipePage extends StatelessWidget {
  const EditRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: _content(),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }

  Widget _content() {
    return Column(
      children: [
        _photoPicker(),
        _forms(),
      ],
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
    );
  }

  Widget _titleForm() {
    return const TextForm(hintText: 'Recipe title');
  }

  Widget _timeForm() {
    return const Expanded(
      child: TextForm(hintText: 'Recipe time'),
    );
  }

  Widget _energyForm() {
    return const Expanded(
      child: TextForm(hintText: 'Kcals'),
    );
  }
}
