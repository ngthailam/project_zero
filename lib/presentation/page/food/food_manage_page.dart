import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_state.dart';
import 'package:de1_mobile_friends/presentation/page/food/widgets/create_food_dialog.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodManagePage extends StatefulWidget {
  const FoodManagePage({Key? key}) : super(key: key);

  @override
  State<FoodManagePage> createState() => _FoodManagePageState();
}

class _FoodManagePageState extends State<FoodManagePage> {
  FoodManageCubit? _cubit;

  TextEditingController? _createTextEdtCtrl;
  FocusNode? _createTextFocusNode;

  @override
  void initState() {
    _cubit = getIt<FoodManageCubit>();
    _createTextEdtCtrl = TextEditingController();
    _createTextFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _cubit?.disposeManual();
    _createTextEdtCtrl?.dispose();
    _createTextFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider<FoodManageCubit>(
          create: (context) => _cubit!..initialize(),
          child: Stack(
            children: [
              _foodList(),
              _createFoodFab(context),
            ],
          )),
    );
  }

  Widget _createFoodFab(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        backgroundColor: colorFa6d85,
        onPressed: () async {
          final data = await showCreateFoodDialog(context);
          if (data != null) {
            _cubit?.addFood(data.foodName);
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _foodList() {
    return BlocConsumer<FoodManageCubit, FoodManageState>(
      listener: (context, state) {
        if (state is FoodManageErrorState && state.foods?.isNotEmpty != true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error ${state.e}")));
        }
      },
      builder: (context, state) {
        if (state is FoodManageInitialState) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state.foods?.isNotEmpty == true) {
          final list = state.foods!;
          return ListView.builder(
            itemBuilder: (context, i) {
              final item = list[i];
              final double topMargin = i == 0 ? 18 : 4;
              return _FoodItem(topMargin: topMargin, item: item, cubit: _cubit);
            },
            itemCount: list.length,
          );
        }

        if (state.foods?.isEmpty == true) {
          return const Center(
            child: Text("No food yet"),
          );
        }

        return const Center(
          child: Text("Something went wrong"),
        );
      },
    );
  }
}

class _FoodItem extends StatelessWidget {
  _FoodItem({
    Key? key,
    required this.topMargin,
    required this.item,
    required FoodManageCubit? cubit,
  })  : _cubit = cubit,
        super(key: key);

  final double topMargin;
  final Food item;
  final FoodManageCubit? _cubit;

  final ExpandableController _controller =
      ExpandableController(initialExpanded: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: topMargin,
        left: 32,
        right: 32,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: InkWell(
          onTap: () {
            _controller.toggle();
          },
          child: Column(
            children: [
              _header(context),
              ExpandableNotifier(
                controller: _controller,
                child: Expandable(
                  collapsed: const SizedBox(
                    height: 1,
                    width: double.infinity,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Places that sell this food:',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      _places(),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _places() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: item.places.keys.length + 1,
      itemBuilder: (context, i) {
        if (i == item.places.keys.length) {
          return _addPlaceBtn();
        }
        return Container();
      },
    );
  }

  Widget _addPlaceBtn() {
    return InkWell(
      onTap: () {
        // Add a place
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
              'Add a place',
              style: TextStyle(
                  color: colorFa6d85, fontSize: 14, fontFamily: 'OpenSans'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.name,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            final data = await showCreateFoodDialog(context, food: item);
            if (data != null) {
              _cubit?.editFood(data.id, data.foodName);
            }
          },
          icon: const Icon(
            Icons.edit,
            size: 24,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            _cubit?.deleteFood(item.id);
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
}
