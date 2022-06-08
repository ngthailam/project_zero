import 'package:confetti/confetti.dart';
import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/food_wheel.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/food_wheel_filter.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/spin_result.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/tu_ai_chat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageSmall extends StatefulWidget {
  const HomePageSmall({Key? key, required this.confettiController})
      : super(key: key);

  final ConfettiController confettiController;

  @override
  State<HomePageSmall> createState() => _HomePageSmallState();
}

class _HomePageSmallState extends State<HomePageSmall> {
  HomeCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit ??= context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _mainTitle(),
              const SizedBox(height: 32),
              SpinResult(
                controller: widget.confettiController,
              ),
              FoodWheel(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                stream: _cubit!.wheelController.stream,
                onSpinEnd: () => _cubit!.onSpinAnimEnd(),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.foodManage);
                },
                child: const Text("Edit foods"),
              ),
              const SizedBox(height: 16),
              const Text(
                "Wheel filter",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              FoodWheelFilter(
                filterMap: _cubit!.currentFilterMap,
                onSelected: (String filterKey, bool newBoolValue) =>
                    _cubit?.onChangeFilter(filterKey, newBoolValue),
              ),
              const SizedBox(height: 64),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: TuAiChatBox(
                  onRequestFilterByFoodType: (type) {
                    _cubit?.onChangeFilterAll(type);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainTitle() {
    return const Text(
      "What to eat for lunch? Spin the wheel!!!",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }
}
