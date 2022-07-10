import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/place/common/add_food_in_place_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/place/common/add_food_in_place_state.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_button.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_input.dart';
import 'package:de1_mobile_friends/utils/load_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> showAddFoodInPlace(BuildContext context,
    {required Place place}) {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Label',
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return AlertDialog(
        content: AddFoodInPlace(place: place),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
      );
    },
  );
}

class AddFoodInPlace extends StatefulWidget {
  const AddFoodInPlace({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  State<AddFoodInPlace> createState() => _AddFoodInPlaceState();
}

class _AddFoodInPlaceState extends State<AddFoodInPlace> {
  final TextEditingController _controller = TextEditingController();
  final ExpandableController _expandableController = ExpandableController();

  final FocusNode _focusNode = FocusNode();

  final AddFoodInPlaceCubit _cubit = getIt();

  Food? _pickedFood;

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
    _focusNode.dispose();
    _expandableController.dispose();
    _cubit.manualDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider<AddFoodInPlaceCubit>(
      create: (context) => _cubit,
      child: BlocListener<AddFoodInPlaceCubit, AddFoodInPlaceState>(
        listenWhen: (previous, current) =>
            previous.addFoodLoadState != current.addFoodLoadState,
        listener: (context, state) {
          if (state.addFoodLoadState == LoadState.success) {
            Navigator.of(context).pop(true);
          }
        },
        child: Container(
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
              const SizedBox(height: 32),
              _inputField(),
              const SizedBox(height: 16),
              _placesHint(),
              const SizedBox(height: 16),
              _confirmBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Text _title() {
    return const Text(
      'What foods does this place sell?',
      style:
          TextStyle(fontFamily: 'OpenSans', fontSize: 22, color: colorFa6d85),
    );
  }

  Widget _inputField() {
    return PrimaryInput(
      hint: 'Enter name to find food',
      focusNode: _focusNode,
      textEditingController: _controller,
      onChanged: (String text) {
        _cubit.searchFoods(text);
        if (text.isEmpty) {
          if (_expandableController.expanded) {
            _expandableController.toggle();
          }
        } else {
          if (!_expandableController.expanded) {
            _expandableController.toggle();
          }
        }
      },
    );
  }

  Widget _placesHint() {
    return ExpandableNotifier(
      controller: _expandableController,
      child: Expandable(
        expanded: BlocBuilder<AddFoodInPlaceCubit, AddFoodInPlaceState>(
          builder: (context, state) {
            final foods = state.foods;
            if (foods == null) return const CupertinoActivityIndicator();
            if (foods.isEmpty == true) return const Text('No matching results');
            return SizedBox(
              height: isMobile(context) ? 120 : 240,
              child: ListView.builder(
                itemCount: foods.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      _pickedFood = foods[i];
                      _controller.text = foods[i].name;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(foods[i].name),
                    ),
                  );
                },
              ),
            );
          },
        ),
        collapsed: const SizedBox.shrink(),
      ),
    );
  }

  PrimaryButton _confirmBtn(BuildContext context) {
    return PrimaryButton(
      text: 'Confirm',
      onPressed: () {
        if (_pickedFood == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Must pick a food'),
            ),
          );
          return;
        }

        if (_controller.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Food name cannot be empty'),
            ),
          );
          return;
        }

        _cubit.addFoodInPlace(_pickedFood, widget.place.id);
      },
    );
  }
}
