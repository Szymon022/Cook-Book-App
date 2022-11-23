import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final List<Color> _recipes = [Colors.blue, Colors.brown, Colors.green];
  final List<Color> _recipes =
      List<Color>.generate(3, (index) => Colors.red.withAlpha(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeAppBar(),
      body: Column(
        children: [_homeContent()],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar();
  }

  Widget _homeContent() {
    return Expanded(
      child: ListView.builder(
        itemCount: _recipes.length + 1,
        itemBuilder: (context, index) {
          if (index == _recipes.length) {
            return const SizedBox(height: 80);
          } else {
            return _RecipeItem(_recipes[index]);
          }
        },
      ),
    );
  }
}

class _RecipeItem extends StatelessWidget {
  _RecipeItem(this._itemColor);

  final Color _itemColor;
  final String burger =
      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Center(
        child: Card(
          elevation: 4,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _recipePhoto(),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
        _recipeTitle('Cheeseburger'),
        _timeIndicator('30 min'),
      ],
    );
  }

  Widget _recipeTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
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
