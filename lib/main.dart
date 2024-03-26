import 'package:cook_book_app/app_root.dart';
import 'package:cook_book_app/storage/cook_book_hive.dart';
import 'package:flutter/material.dart';

void main() async {
  await CookBookHive.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRoot();
  }
}
