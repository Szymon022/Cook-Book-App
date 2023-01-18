import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm({
    Key? key,
    this.initialValue,
    this.hintText,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
  }) : super(key: key);

  final String? initialValue;
  final String? hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
