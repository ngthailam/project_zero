import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/food/common/add_place_in_food_dialog.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_state.dart';
import 'package:de1_mobile_friends/presentation/page/food/widgets/create_food_dialog.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:de1_mobile_friends/presentation/widget/search_box.dart';
import 'package:de1_mobile_friends/utils/string_ext.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodManagePage extends StatefulWidget {
  const FoodManagePage({Key? key}) : super(key: key);

  @override
  State<FoodManagePage> createState() => _FoodManagePageState();
}

class _FoodManagePageState extends State<FoodManagePage>
    with AutomaticKeepAliveClientMixin {
  FoodManageCubit? _cubit;

  TextEditingController? _createTextEdtCtrl;
  FocusNode? _createTextFocusNode;

  @override
  void initState() {
    _cubit = getIt<FoodManageCubit>();
    _createTextEdtCtrl = TextEditingController();
    _createTextFocusNode = FocusNode();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 330), () {
        _cubit?.initialize();
      });
    });
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
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider<FoodManageCubit>(
          create: (context) => _cubit!,
          child: BlocBuilder<FoodManageCubit, FoodManageState>(
            buildWhen: (previous, current) {
              return previous.displayedFoods != current.displayedFoods;
            },
            builder: (context, state) {
              if (state.displayedFoods.isEmpty) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SearchBox(
                            hintText: 'Search food',
                            onChanged: (text) {
                              _cubit?.searchFood(text);
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(child: _foodList()),
                      ],
                    ),
                    _createFoodFab(context),
                  ],
                ),
              );
            },
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
          final data = await showCreateFoodDialog(
            context,
            categories: _cubit!.getCategories,
          );
          if (data != null) {
            _cubit?.addFood(data.foodName, data.foodCategories);
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
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: BlocConsumer<FoodManageCubit, FoodManageState>(
        listener: (context, state) {
          // Handle error later
        },
        builder: (context, state) {
          if (state.displayedFoods.isEmpty) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (state.displayedFoods.isNotEmpty) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: state.displayedFoods.keys.map((e) {
                  final foods = state.displayedFoods[e];
                  if (foods == null) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          getCategoryTitle(e),
                          style: const TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorFa6d85),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _foodsInACategory(foods),
                      SizedBox(height: isMobile(context) ? 22 : 60),
                    ],
                  );
                }).toList(),
              ),
            );
          }

          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }

  String getCategoryTitle(String categoryKey) {
    switch (categoryKey) {
      case 'none':
        return 'Uncategorized Foods';
      case 'dry':
        return 'Dry Foods';
      case 'water':
        return 'Watery Foods';
      case 'celebratory':
        return 'Foods for celebrations';
      case 'party':
        return 'Foods for parties';
      case 'unique':
        return 'Unique Foods';
      default:
        return categoryKey.capitalize();
    }
  }

  Widget _foodsInACategory(List<Food> foods) {
    // Need to fiqure this out
    final divider =
        getOnScreenSize(context, small: 2, medium: 4, large: 5, huge: 7);
    int desiredWidth = (MediaQuery.of(context).size.width - 32) ~/ divider;

    return SizedBox(
      height: desiredWidth.toDouble() +
          getOnScreenSize(context, small: 64, medium: 64, large: 60, huge: 52),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          final item = foods[i];
          return _FoodItem(item: item, listHeight: desiredWidth.toDouble());
        },
        itemCount: foods.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _FoodItem extends StatefulWidget {
  const _FoodItem({
    Key? key,
    required this.item,
    required this.listHeight,
  }) : super(key: key);

  final Food item;
  final double listHeight;

  @override
  State<_FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<_FoodItem> {
  final ExpandableController _controller =
      ExpandableController(initialExpanded: false);

  bool _isHovered = false;
  bool _isExpanded = false;

  bool get isFocused => _isHovered && !_isExpanded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
          _controller.toggle();
        });
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onHover: (bool isHovered) {
        if (isHovered != _isHovered) {
          setState(() {
            _isHovered = isHovered;
          });
        }
      },
      child: Container(
          width: widget.listHeight,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: colorFa6d85.withOpacity(0.8)),
            color: isFocused ? colorFa6d85 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 2),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              )
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: ExpandableNotifier(
            controller: _controller,
            child: Expandable(
              collapsed: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/img_food_pho.png',
                    fit: BoxFit.cover,
                  ),
                  Text(
                    widget.item.name + '\n',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: isFocused ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color:
                        isFocused ? Colors.white : colorFa6d85.withOpacity(0.6),
                  ),
                  const SizedBox(height: 8),
                  _editAndDelete(context),
                ],
              ),
              expanded: _places(),
            ),
          )),
    );
  }

  Widget _places() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.item.placeList.length + 2,
      itemBuilder: (context, i) {
        if (i == 0) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Places with this food:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        if (i == widget.item.placeList.length + 1) {
          return _addPlaceBtn();
        }

        final placeItem = widget.item.placeList[i - 1];
        final String directions = placeItem.direction?.isNotEmpty == true
            ? widget.item.placeList[i - 1].direction!
            : '(No directions)';
        return InkWell(
          // TODO: if enable this then click area to flip card is not enough
          // onTap: () {
          // Navigator.of(context)
          //     .pushNamed(AppRouter.placeDetail, arguments: placeItem.id);
          // },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeItem.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  directions,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _addPlaceBtn() {
    return InkWell(
      onTap: () async {
        await showAddPlaceInFoodDialog(context, food: widget.item);
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

  Widget _editAndDelete(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        IconButton(
          onPressed: () async {
            final data = await showCreateFoodDialog(
              context,
              food: widget.item,
              categories: context.read<FoodManageCubit>().getCategories,
            );
            if (data != null) {
              context
                  .read<FoodManageCubit>()
                  .editFood(data.id, data.foodName, data.foodCategories);
            }
          },
          icon: Icon(
            Icons.edit,
            size: 20,
            color: isFocused ? Colors.white : Colors.grey,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<FoodManageCubit>().deleteFood(widget.item.id);
          },
          icon: Icon(
            Icons.delete,
            size: 20,
            color: isFocused ? Colors.white : Colors.grey,
          ),
        )
      ],
    );
  }
}
