import 'dart:async';

import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key, required this.onChanged, this.hintText})
      : super(key: key);

  final Function(String text) onChanged;
  final String? hintText;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: colorFa6d85,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: colorFa6d85.withOpacity(0.5),
          ),
        ),
        fillColor: Colors.grey.withOpacity(0.1),
        contentPadding:
            const EdgeInsets.only(left: 24, bottom: 8, top: 8, right: 24),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: colorFa6d85),
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        hintText: widget.hintText ?? '',
      ),
      onChanged: (String text) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 400), () async {
          widget.onChanged(text);
        });
      },
    );
  }
}
