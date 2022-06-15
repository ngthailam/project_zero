import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:flutter/material.dart';

class OccasionPicker extends StatefulWidget {
  const OccasionPicker({
    Key? key,
    required this.occasion,
    required this.onPickOccasion,
  }) : super(key: key);

  final Occasion occasion;
  final Function(Occasion occasion) onPickOccasion;

  @override
  State<OccasionPicker> createState() => _OccasionPickerState();
}

class _OccasionPickerState extends State<OccasionPicker> {
  Map<String, dynamic> _occasionMap = {};

  @override
  void initState() {
    _occasionMap = widget.occasion.occasions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: _occasionMap.keys.map(
        (e) {
          final isSelected = _occasionMap[e];
          return ChoiceChip(
            label: Text(e),
            selectedColor: Colors.blue,
            labelStyle:
                TextStyle(color: isSelected ? Colors.white : Colors.grey),
            selected: isSelected,
            onSelected: (newBoolValue) {
              setState(() {
                _occasionMap[e] = newBoolValue;
                widget.onPickOccasion(Occasion(occasions: _occasionMap));
              });
            },
          );
        },
      ).toList(),
    );
  }
}
