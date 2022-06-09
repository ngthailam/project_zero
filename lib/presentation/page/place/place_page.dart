import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({Key? key}) : super(key: key);

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  PlaceCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PlaceCubit>();
  }

  @override
  void dispose() {
    _cubit?.manualDispose();
    _cubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PlaceCubit>(
          create: (context) => _cubit!..initialze(),
          child: Stack(
            children: [
              _list(),
              _fab(),
            ],
          )),
    );
  }

  Widget _list() {
    return BlocConsumer<PlaceCubit, PlaceState>(
      listener: (context, state) {
        if (state is PlaceErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.e}")),
          );
        }
      },
      builder: (context, state) {
        final places = state.places;

        if (places?.isNotEmpty != true) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
          itemCount: places!.length,
          itemBuilder: (context, i) {
            return Text(places[i].name);
          },
        );
      },
    );
  }

  Widget _fab() {
    return Positioned(
      bottom: 32,
      right: 32,
      child: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          // show add place
        },
      ),
    );
  }
}
