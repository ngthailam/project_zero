import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/domain/interactor/food/search_food_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/place/common/add_food_in_place_dialog.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_state.dart';
import 'package:de1_mobile_friends/presentation/page/place_add/place_add_page.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:de1_mobile_friends/presentation/widget/search_text_field.dart';
import 'package:de1_mobile_friends/utils/string_ext.dart';
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
      backgroundColor: Colors.transparent,
      body: BlocProvider<PlaceCubit>(
          create: (context) => _cubit!..initialze(),
          child: Stack(
            children: [
              _places(),
              _createPlaceFab(),
            ],
          )),
    );
  }

  Widget _places() {
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

        return Padding(
          padding:
              EdgeInsets.all(isMobile(context) ? 16 : 48).copyWith(bottom: 0),
          child: GridView.builder(
            itemCount: places!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: getOnScreenSize<int>(
                context,
                small: 2,
                medium: 3,
                large: 4,
              ), // TODO: add more width handling here
            ),
            itemBuilder: (context, i) {
              return _placeItem(places[i], i);
            },
          ),
        );
      },
    );
  }

  Widget _placeItem(Place place, int i) {
    return _PlaceItem(
      place: place,
    );
  }

  Widget _createPlaceFab() {
    return Positioned(
      bottom: 32,
      right: 32,
      child: FloatingActionButton(
        backgroundColor: colorFa6d85,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showSavePlaceDialog(context);
        },
      ),
    );
  }
}

class _PlaceItem extends StatelessWidget {
  const _PlaceItem({
    Key? key,
    required this.place,
  }) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouter.placeDetail,
          arguments: place.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(
            color: colorFa6d85,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _direction(),
              const SizedBox(height: 8),
              _ratings(),
              const SizedBox(height: 16),
              const Text(
                'Foods in this place:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
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
        Expanded(
          child: Text(
            place.name.capitalize(),
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 16),
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

  Widget _direction() {
    return Text(
      place.direction?.isNotEmpty == true
          ? place.direction!
          : '(No directions)',
      style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black.withOpacity(0.7)),
    );
  }

  Widget _ratings() {
    final rating = place.getAvgRating;
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          Icon(
            Icons.star_rate,
            color: i <= rating ? Colors.amber : Colors.grey,
          ),
      ],
    );
  }

  Widget _addFoodsBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showAddFoodInPlace(context, place: place);
      },
      child: Padding(
        padding: const EdgeInsets.all(8).copyWith(left: 0),
        child: Row(
          children: const [
            Icon(
              Icons.add_circle_outline_outlined,
              color: colorFa6d85,
            ),
            SizedBox(width: 8),
            Text(
              'Add a food',
              style: TextStyle(
                  color: colorFa6d85, fontSize: 14, fontFamily: 'OpenSans'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _foods() {
    return Expanded(
      child: ListView.builder(
        itemCount: place.foodList.length + 1,
        itemBuilder: (context, i) {
          if (i == place.foodList.length) {
            return _addFoodsBtn(context);
          }

          return Text(place.foodList[i].name);
        },
      ),
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
