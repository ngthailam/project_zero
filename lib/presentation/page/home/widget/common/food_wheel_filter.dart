import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodWheelFilter extends StatelessWidget {
  const FoodWheelFilter({
    Key? key,
    required this.filterMap,
    required this.onSelected,
  }) : super(key: key);

  final Map<String, dynamic> filterMap;
  final Function(String filterKey, bool newBoolValue) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Wrap(
        spacing: 6,
        runSpacing: 6,
        children: filterMap.keys.map((e) {
          final isSelected = filterMap[e];
          return ChoiceChip(
            label: Text(e),
            selectedColor: Colors.blue,
            labelStyle:
                TextStyle(color: isSelected ? Colors.white : Colors.grey),
            selected: isSelected,
            onSelected: (newBoolValue) {
              onSelected(filterMap[e], newBoolValue);
            },
          );
        }).toList(),
      ),
    );
  }
}
