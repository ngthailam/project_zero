import 'dart:async';

import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key, required this.onChanged}) : super(key: key);

  final Function(String text) onChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: "Search food",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
        suffixIcon: const Icon(Icons.search),
      ),
      onChanged: (text) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          widget.onChanged(text);
        });
      },
    );
  }
}
