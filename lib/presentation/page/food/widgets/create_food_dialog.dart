import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_button.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_input.dart';
import 'package:flutter/material.dart';

Future<CreateFoodOutput?> showCreateFoodDialog(
  BuildContext context, {
  Food? food,
  required Map<String, String> categories,
  required Map<String, String> occasions,
}) {
  return showDialog<CreateFoodOutput>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Label',
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return AlertDialog(
        content: CreateFoodDialog(
          food: food,
          foodCategories: categories,
          occasions: occasions,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
      );
    },
  );
}

class CreateFoodOutput {
  final String? id;
  final String foodName;
  final Map<String, bool> foodCategories;
  final Map<String, bool> occasions;

  CreateFoodOutput({
    this.id,
    required this.foodName,
    required this.foodCategories,
    required this.occasions,
  });
}

class CreateFoodDialog extends StatefulWidget {
  const CreateFoodDialog({
    Key? key,
    this.food,
    required this.foodCategories,
    required this.occasions,
  }) : super(key: key);

  final Food? food;
  final Map<String, String> foodCategories;
  final Map<String, String> occasions;

  @override
  State<CreateFoodDialog> createState() => _CreateFoodDialogState();
}

class _CreateFoodDialogState extends State<CreateFoodDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.food?.name ?? '');

  final FocusNode _focusNode = FocusNode();

  final Map<String, bool> _foodCategories = <String, bool>{};
  final Map<String, bool> _foodOccasions = <String, bool>{};

  @override
  void initState() {
    // ignore: avoid_function_literals_in_foreach_calls
    widget.food?.categories?.entries.forEach((element) {
      _foodCategories[element.key] = element.value;
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: getOnScreenSize<double>(
        context,
        small: width - 64,
        medium: width / 2,
        large: width / 3,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _title(),
          const SizedBox(height: 48),
          _inputField(),
          const SizedBox(height: 16),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('What is the occasion?')),
          const SizedBox(height: 8),
          _foodOccasionPicker(),
          const SizedBox(height: 16),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('What is this food type? (Optional)')),
          const SizedBox(height: 8),
          _foodCategoryPicker(),
          const SizedBox(height: 16),
          _confirmBtn(context),
        ],
      ),
    );
  }

  Text _title() {
    return Text(
      widget.food == null ? 'Create new food' : 'Edit [${widget.food?.name}]',
      style: const TextStyle(
          fontFamily: 'OpenSans', fontSize: 22, color: colorFa6d85),
    );
  }

  PrimaryInput _inputField() {
    return PrimaryInput(
      hint: 'Enter food name',
      focusNode: _focusNode,
      textEditingController: _controller,
    );
  }

  PrimaryButton _confirmBtn(BuildContext context) {
    return PrimaryButton(
      text: 'Confirm',
      onPressed: () {
        if (_controller.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Food name cannot be empty'),
            ),
          );
          return;
        }

        if (_foodOccasions.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Must choose at least 1 occasion'),
            ),
          );
          return;
        }

        Navigator.of(context).pop(
          CreateFoodOutput(
            foodName: _controller.text,
            id: widget.food?.id,
            foodCategories: _foodCategories,
            occasions: _foodOccasions,
          ),
        );
      },
    );
  }

  Widget _foodCategoryPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: widget.foodCategories.keys.map((e) {
            return CategoryChoiceChip(
              categoryMapEntry: MapEntry(e, widget.foodCategories[e]!),
              isPreSelected: widget.food?.categories?.keys.contains(e) == true,
              onSelect: (String key, bool isSelected) {
                if (isSelected) {
                  _foodCategories[key] = isSelected;
                } else {
                  _foodCategories.remove(key);
                }
              },
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _foodOccasionPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: widget.occasions.keys.map((e) {
            return CategoryChoiceChip(
              categoryMapEntry: MapEntry(e, widget.occasions[e]!),
              isPreSelected: widget.food?.occasion?.keys.contains(e) == true,
              onSelect: (String key, bool isSelected) {
                if (isSelected) {
                  _foodOccasions[key] = isSelected;
                } else {
                  _foodOccasions.remove(key);
                }
              },
            );
          }).toList(),
        )
      ],
    );
  }
}

class CategoryChoiceChip extends StatefulWidget {
  const CategoryChoiceChip({
    Key? key,
    required this.categoryMapEntry,
    this.isPreSelected = false,
    required this.onSelect,
  }) : super(key: key);

  final MapEntry<String, String> categoryMapEntry;
  final bool isPreSelected;
  final Function(String categoryKey, bool isSelected) onSelect;

  @override
  State<CategoryChoiceChip> createState() => _CategoryChoiceChipState();
}

class _CategoryChoiceChipState extends State<CategoryChoiceChip> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isPreSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.categoryMapEntry.value),
      selectedColor: colorFa6d85,
      labelStyle: TextStyle(
          color: _isSelected ? Colors.white : Colors.grey.withOpacity(0.7)),
      selected: _isSelected,
      onSelected: (bool selected) {
        if (_isSelected != selected) {
          setState(() {
            _isSelected = selected;
            widget.onSelect(widget.categoryMapEntry.key, _isSelected);
          });
        }
      },
    );
  }
}
