import 'dart:math';

import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/page/home/bloc/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/bloc/home_state.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodWheel extends StatefulWidget {
  const FoodWheel({
    Key? key,
    required this.onSpinEnd,
    this.height,
    this.width,
  }) : super(key: key);

  final VoidCallback onSpinEnd;
  final double? height;
  final double? width;

  @override
  State<FoodWheel> createState() => _FoodWheelState();
}

class _FoodWheelState extends State<FoodWheel> {
  int _selectedIndex = -1;

  PageController _pageController = PageController(
    viewportFraction: 0.3,
    initialPage: 4,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.displayedFoods != current.displayedFoods,
      listener: (BuildContext context, HomeState state) {
        if (state.spinStatus == HomeSpinStatus.spinning) {
          onSpinning(state);
          return;
        }
      },
      builder: (BuildContext context, HomeState state) {
        final foods = state.displayedFoods;
        if (foods?.isNotEmpty == true) {
          _pageController = PageController(
            viewportFraction: getOnScreenSize<double>(
              context,
              small: 0.7,
              medium: 0.4,
              large: 0.2,
            ),
            initialPage: foods!.length ~/ 2,
          );

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = -1;
              });
              context.read<HomeCubit>().onSpin();
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  final itemIdx = index % foods.length;
                  final item = foods[itemIdx];
                  final isSelected = _selectedIndex == itemIdx;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) {
                        return _itemTransitionBuilder(
                          child,
                          animation,
                          item.id,
                          index,
                        );
                      },
                      layoutBuilder: (widget, list) =>
                          Stack(children: [widget!, ...list]),
                      switchInCurve: Curves.ease,
                      switchOutCurve: Curves.ease.flipped,
                      child: isSelected
                          ? _itemFront(item, itemIdx)
                          : _itemBack(item, itemIdx),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void onSpinning(HomeState state) {
    _pageController
        .animateToPage(
      state.pickedFoodIndex! + (state.displayedFoods!.length * 2),
      duration: const Duration(seconds: 3),
      curve: Curves.easeInOutCubic,
    )
        .then((value) {
      setState(() {
        _selectedIndex = state.pickedFoodIndex!;
      });
      context.read<HomeCubit>().onSpinEnd();
    });
  }

  Widget _itemBack(Food item, int index) {
    return SizedBox(
      key: ValueKey('Back-${item.id}-$index'),
      height: double.infinity,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset('assets/img/img_food_card_back.png'),
      ),
    );
  }

  Widget _itemFront(Food item, int index) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF093684), width: 4)),
      key: ValueKey('Front-${item.id}-$index'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Comming soon...')));
            },
            child: const Text(
              'Places that sell this',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF093684),
                  fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemTransitionBuilder(
      Widget widget, Animation<double> animation, String itemId, int index) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey('Front-$itemId-$index') == widget!.key;
        final rotationY = isFront
            ? rotateAnimation.value
            : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
