import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/place_add/place_add_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/place_add/place_add_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future showAddPlaceBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    isDismissible: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return Wrap(
        children: const [PlaceAddPage()],
      );
    },
  );
}

class PlaceAddPage extends StatefulWidget {
  const PlaceAddPage({Key? key}) : super(key: key);

  @override
  State<PlaceAddPage> createState() => _PlaceAddPageState();
}

class _PlaceAddPageState extends State<PlaceAddPage> {
  PlaceAddCubit? _cubit;
  TextEditingController? _nameTextCtrl;
  TextEditingController? _directionTextCtrl;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PlaceAddCubit>();
    _nameTextCtrl = TextEditingController();
    _directionTextCtrl = TextEditingController();
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
    return BlocProvider<PlaceAddCubit>(
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
        child: Stack(
          children: [
            Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(16),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                const Expanded(
                  child: Center(
                    child: Text('Add a new place'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 90, left: 16, right: 16, top: 48),
              child: Container(
                constraints: const BoxConstraints(minHeight: 320),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _nameTextField(),
                    const SizedBox(height: 16),
                    _directionTextField(),
                    const SizedBox(height: 16),
                    _foodsSelection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Positioned(bottom: 16, child: _confirmBtn()),
          ],
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextField(
      onChanged: _cubit!.onNameChanged,
      decoration: const InputDecoration(
        hintText: 'Place name',
      ),
      controller: _nameTextCtrl,
    );
  }

  Widget _directionTextField() {
    return TextField(
      onChanged: _cubit!.onDirectionChanged,
      decoration: const InputDecoration(
        hintText: 'Direction to the place',
      ),
      controller: _directionTextCtrl,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: () {
          _cubit!.addPlace();
        },
        child: const Text('Confirm'),
      ),
    );
  }
}
