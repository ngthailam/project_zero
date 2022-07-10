import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/food/common/add_place_in_food_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/food/common/add_place_in_food_state.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_button.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_input.dart';
import 'package:de1_mobile_friends/utils/load_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> showAddPlaceInFoodDialog(BuildContext context,
    {required Food food}) {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Label',
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return AlertDialog(
        content: AddPlaceInFoodPage(food: food),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
      );
    },
  );
}

class AddPlaceInFoodPage extends StatefulWidget {
  const AddPlaceInFoodPage({Key? key, required this.food}) : super(key: key);

  final Food food;

  @override
  State<AddPlaceInFoodPage> createState() => _AddPlaceInFoodPageState();
}

class _AddPlaceInFoodPageState extends State<AddPlaceInFoodPage> {
  final TextEditingController _controller = TextEditingController();
  final ExpandableController _expandableController = ExpandableController();

  final FocusNode _focusNode = FocusNode();

  final AddPlaceInFoodCubit _cubit = getIt();

  Place? _pickedPlace;

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
    return BlocProvider<AddPlaceInFoodCubit>(
      create: (context) => _cubit,
      child: BlocListener<AddPlaceInFoodCubit, AddPlaceInFoodState>(
        listenWhen: (previous, current) =>
            previous.addPlaceLoadState != current.addPlaceLoadState,
        listener: (context, state) {
          if (state.addPlaceLoadState == LoadState.success) {
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
      'Where can you find this food?',
      style:
          TextStyle(fontFamily: 'OpenSans', fontSize: 22, color: colorFa6d85),
    );
  }

  Widget _inputField() {
    return PrimaryInput(
      hint: 'Enter name to find place',
      focusNode: _focusNode,
      textEditingController: _controller,
      onChanged: (String text) {
        _cubit.searchPlaces(text);
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
        expanded: BlocBuilder<AddPlaceInFoodCubit, AddPlaceInFoodState>(
          builder: (context, state) {
            final places = state.places;
            if (places == null) return const CupertinoActivityIndicator();
            if (places.isEmpty == true) {
              return const Text('No matching results');
            }
            return SizedBox(
              height: isMobile(context) ? 200 : 360,
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      _pickedPlace = places[i];
                      _controller.text = places[i].name;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(places[i].name),
                          const SizedBox(height: 4),
                          Text(
                            places[i].direction?.isNotEmpty == true
                                ? places[i].direction!
                                : '(No directions)',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
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
        if (_pickedPlace == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Must pick a place'),
            ),
          );
          return;
        }
        if (_controller.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Place name cannot be empty'),
            ),
          );
          return;
        }

        _cubit.addPlaceInFood(_pickedPlace, widget.food.id);
      },
    );
  }
}
