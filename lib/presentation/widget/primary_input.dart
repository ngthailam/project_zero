import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class PrimaryInput extends StatelessWidget {
  const PrimaryInput({
    Key? key,
    this.focusNode,
    this.textEditingController,
    this.hint,
    this.outlineInputBorder,
    this.onChanged,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final String? hint;
  final OutlineInputBorder? outlineInputBorder;
  final Function(String text)? onChanged;

  OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(
          color: colorFa6d85,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: textEditingController,
      cursorColor: colorFa6d85,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        fillColor: Colors.white,
        focusedBorder: outlineInputBorder ?? border,
        enabledBorder: outlineInputBorder ?? border,
      ),
    );
  }
}
