import 'package:flutter/material.dart';

class EditRecipePage extends StatelessWidget {
  const EditRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text('AppBar'),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_back_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.check),
        ),
      ],
    );
  }

  Widget _content() {
    return ListView(
      children: [],
    );
  }

  Widget titleForm() {
    return FormField(
      builder: (state) {
        state
        .
      },
      validator: (sth) {},
    );
  }
}












