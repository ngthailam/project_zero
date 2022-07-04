import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/place_add/place_add_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/place_add/place_add_state.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_button.dart';
import 'package:de1_mobile_friends/presentation/widget/primary_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<SavePlaceOutput?> showSavePlaceDialog(
  BuildContext context, {
  Place? place,
}) {
  return showDialog<SavePlaceOutput>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Label',
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return AlertDialog(
        content: SavePlacePage(
          place: place,
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

class SavePlaceOutput {
  // add things here
}

class SavePlacePage extends StatefulWidget {
  const SavePlacePage({Key? key, this.place}) : super(key: key);

  final Place? place;

  @override
  State<SavePlacePage> createState() => _SavePlacePageState();
}

class _SavePlacePageState extends State<SavePlacePage> {
  PlaceAddCubit? _cubit;
  TextEditingController? _nameTextCtrl;
  TextEditingController? _directionTextCtrl;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PlaceAddCubit>();
    _nameTextCtrl = TextEditingController()
      ..addListener(() {
        _cubit!.onNameChanged(_nameTextCtrl?.text ?? '');
      });
    _directionTextCtrl = TextEditingController()
      ..addListener(() {
        _cubit!.onDirectionChanged(_directionTextCtrl?.text ?? '');
      });
  }

  @override
  void dispose() {
    _cubit?.manualDispose();
    _cubit = null;
    _nameTextCtrl?.dispose();
    _directionTextCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: BlocProvider<PlaceAddCubit>(
        create: (context) => _cubit!..initialize(),
        child: BlocListener<PlaceAddCubit, PlaceAddState>(
          listener: (context, state) {
            if (state is PlaceAddSuccessState) {
              Navigator.of(context).pop();
            }

            if (state is PlaceAddErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Error ${state.e}')));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _title(),
                const SizedBox(height: 16),
                _nameTextField(),
                const SizedBox(height: 16),
                _directionTextField(),
                const SizedBox(height: 16),
                _foodsSelection(),
                const SizedBox(height: 16),
                _confirmBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _title() {
    return Text(
      widget.place == null
          ? 'Create new place'
          : 'Edit [${widget.place?.name}]',
      style: const TextStyle(
          fontFamily: 'OpenSans', fontSize: 22, color: colorFa6d85),
    );
  }

  Widget _nameTextField() {
    return PrimaryInput(
      hint: 'Place name',
      textEditingController: _nameTextCtrl,
    );
  }

  Widget _directionTextField() {
    return PrimaryInput(
      hint: 'Direction to the place',
      textEditingController: _directionTextCtrl,
    );
  }

  Widget _foodsSelection() {
    return BlocBuilder<PlaceAddCubit, PlaceAddState>(
      builder: (context, PlaceAddState state) {
        if (state is PlaceAddPrimaryState && state.foods != null) {
          return Container(); // impl later
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _confirmBtn() {
    return PrimaryButton(
      text: 'Confirm',
      onPressed: () {
        _cubit!.addPlace();
      },
    );
  }
}
