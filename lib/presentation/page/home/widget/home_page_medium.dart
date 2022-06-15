import 'package:confetti/confetti.dart';
import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/food_wheel.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/food_wheel_filter.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/food_wheel_occasion_filter.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/spin_result.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/tu_ai_chat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageMedium extends StatefulWidget {
  const HomePageMedium({
    Key? key,
    required this.confettiController,
  }) : super(key: key);

  final ConfettiController confettiController;

  @override
  State<HomePageMedium> createState() => _HomePageMediumState();
}

class _HomePageMediumState extends State<HomePageMedium> {
  HomeCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit ??= context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32).copyWith(top: 0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "What to eat for lunch? Spin the wheel!!!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 52),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _left()),
                const SizedBox(width: 32),
                Expanded(child: _rightSide()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightSide() {
    return Column(
      children: [
        _result(),
        Expanded(
          child: TuAiChatBox(
            onRequestFilterByFoodType: (type) {
              _cubit?.onChangeFilterAll(type);
            },
          ),
        )
      ],
    );
  }

  Widget _result() {
    return SpinResult(
      controller: widget.confettiController,
    );
  }

  Widget _left() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _wheel(),
        const SizedBox(height: 32),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouter.foodManage);
          },
          child: const Text("Edit foods"),
        ),
        const SizedBox(height: 16),
        _filters(),
        const SizedBox(height: 16),
        FoodWheelOccasionFilter(
          onPickOccasion: (Occasion occasion) =>
              _cubit?.onChangeOccasionFilter(occasion),
        ),
      ],
    );
  }

  Widget _wheel() {
    return FoodWheel(
      height: 400,
      width: 400,
      stream: _cubit!.wheelController.stream,
      onSpinEnd: () => _cubit!.onSpinAnimEnd(),
    );
  }

  Widget _filters() {
    return FoodWheelFilter(
      filterMap: _cubit!.currentFilterMap,
      onSelected: (String filterKey, bool newBoolValue) =>
          _cubit?.onChangeFilter(filterKey, newBoolValue),
    );
  }
}
