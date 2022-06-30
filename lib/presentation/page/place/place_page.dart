import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/domain/interactor/food/search_food_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_state.dart';
import 'package:de1_mobile_friends/presentation/page/place_add/place_add_page.dart';
import 'package:de1_mobile_friends/presentation/widget/search_text_field.dart';
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
            return _placeItem(places[i], i);
          },
        );
      },
    );
  }

  Widget _placeItem(Place place, int i) {
    return _PlaceItem(
      place: place,
      topMargin: i == 0 ? 18 : 4,
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
          showAddPlaceBottomSheet(context);
        },
      ),
    );
  }
}

class _PlaceItem extends StatelessWidget {
  const _PlaceItem({
    Key? key,
    required this.place,
    required this.topMargin,
  }) : super(key: key);

  final Place place;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRouter.placeDetail, arguments: place.id);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: topMargin,
          left: 32,
          right: 32,
          bottom: 4,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              style: BorderStyle.solid,
              width: 1.0,
            )),
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            children: [
              _header(context),
              _addFood(context),
              _foods(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(place.name)),
        IconButton(
          onPressed: () {
            context.read<PlaceCubit>().deletePlace(place.id);
          },
          icon: const Icon(
            Icons.delete,
            size: 24,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget _addFood(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () async {
            final selectedFood = await showFoodSearchDialog(context);
            context
                .read<PlaceCubit>()
                .addFoodInPlace(placeId: place.id, food: selectedFood);
          },
          child: const Text('Add food'),
        ),
      ],
    );
  }

  Widget _foods() {
    return Row(
      children: place.foods.keys.map((e) {
        return Text("$e, ");
      }).toList(),
    );
  }
}

Future showFoodSearchDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: const _FoodSearch(),
      );
    },
  );
}

class _FoodSearch extends StatefulWidget {
  const _FoodSearch({Key? key}) : super(key: key);

  @override
  State<_FoodSearch> createState() => __FoodSearchState();
}

class __FoodSearchState extends State<_FoodSearch> {
  final ValueNotifier<List<Food>> _searchResults =
      ValueNotifier<List<Food>>([]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          SearchTextField(
            onChanged: (String text) async {
              final results = await getIt<SearchFoodInteractor>().execute(text);
              _searchResults.value = results;
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ValueListenableBuilder<List<Food>>(
                valueListenable: _searchResults,
                builder: (context, value, child) {
                  return Column(
                    children: value.map((e) => _item(e)).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(food);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(food.name),
      ),
    );
  }
}
