import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:flutter/material.dart';

class FoodTypePicker extends StatefulWidget {
  const FoodTypePicker({
    Key? key,
    required this.onChangedType,
  }) : super(key: key);

  final Function(FoodType type) onChangedType;

  @override
  State<FoodTypePicker> createState() => _FoodTypePickerState();
}

class _FoodTypePickerState extends State<FoodTypePicker> {
  Map<String, dynamic>? _foodTypeMap;

  @override
  void initState() {
    _foodTypeMap = FoodType().toJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: _foodTypeMap!.keys.map(
        (e) {
          final isSelected = _foodTypeMap![e];
          return ChoiceChip(
            label: Text(e),
            selectedColor: Colors.blue,
            labelStyle:
                TextStyle(color: isSelected ? Colors.white : Colors.grey),
            selected: isSelected,
            onSelected: (newBoolValue) {
              setState(() {
                _foodTypeMap![e] = newBoolValue;
                widget.onChangedType(FoodType.fromJson(_foodTypeMap!));
              });
            },
          );
        },
      ).toList(),
    );
  }
}
