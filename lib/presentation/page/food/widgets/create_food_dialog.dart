import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_button.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_input.dart';
import 'package:flutter/material.dart';

Future<CreateFoodOutput?> showCreateFoodDialog(
  BuildContext context, {
  Food? food,
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

  CreateFoodOutput({this.id, required this.foodName});
}

class CreateFoodDialog extends StatefulWidget {
  const CreateFoodDialog({Key? key, this.food}) : super(key: key);

  final Food? food;

  @override
  State<CreateFoodDialog> createState() => _CreateFoodDialogState();
}

class _CreateFoodDialogState extends State<CreateFoodDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.food?.name ?? '');

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
          _occasionPicker(),
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

        Navigator.of(context).pop(
          CreateFoodOutput(
            foodName: _controller.text,
            id: widget.food?.id,
          ),
        );
      },
    );
  }

  Widget _occasionPicker() {
    return Wrap();
  }
}
