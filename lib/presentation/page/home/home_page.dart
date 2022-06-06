import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_state.dart';
import 'package:de1_mobile_friends/presentation/widget/tu_ai_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConfettiController? _confettiController;

  HomeCubit? _cubit;

  @override
  void initState() {
    _cubit = getIt<HomeCubit>();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _cubit?.manualDispose();
    _cubit = null;
    _confettiController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text(
              "What to eat for lunch? Spin the wheel!!!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 52),
            Expanded(
              child: BlocProvider<HomeCubit>(
                create: (context) => _cubit!..initialize(),
                child: Row(
                  children: [
                    Expanded(child: _left()),
                    const SizedBox(width: 32),
                    Expanded(child: _rightSide()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rightSide() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _result(),
        const SizedBox(height: 92),
        const Text(
          "Chat with AI:",
          style: TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: TuAiWidget(
            onRequestFilterByFoodType: (type) =>
                _cubit?.onChangeFilterAll(type),
          ),
        ),
      ],
    );
  }

  Widget _result() {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state.foodResultTemp != null) {
        _confettiController!.play();
      }
    }, builder: (context, state) {
      if (state.pickedFood != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You have spinned:",
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 24),
            Text(
              state.pickedFood!.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
            ),
            ConfettiWidget(
              confettiController: _confettiController!,
              blastDirection: -pi / 2,
              emissionFrequency: 0.0001,
              numberOfParticles: 10,
              gravity: 0.3,
            ),
            ConfettiWidget(
              confettiController: _confettiController!,
              blastDirection: -pi / 4,
              emissionFrequency: 0.0001,
              numberOfParticles: 10,
              gravity: 0.3,
            ),
            ConfettiWidget(
              confettiController: _confettiController!,
              blastDirection: -3 * pi / 4,
              emissionFrequency: 0.0001,
              numberOfParticles: 10,
              gravity: 0.3,
            ),
          ],
        );
      }

      return const SizedBox.shrink();
    });
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
        const SizedBox(height: 32),
        SizedBox(
          width: 150,
          height: 80,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 167, 215, 254)),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 232, 232, 232)),
            ),
            onPressed: () {
              _cubit!.onSpin();
            },
            child: const Text(
              "Spin",
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text("Wheel filter"),
        const SizedBox(height: 16),
        _filters(),
      ],
    );
  }

  Widget _wheel() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final foods = state.foods;

        if (foods?.isNotEmpty != true) {
          return const Text("Something went wrong");
        }

        if (foods!.length == 1) {
          return Text("Only 1 option: ${foods[0].name}");
        }

        return SizedBox(
          height: 400,
          width: 400,
          child: FortuneWheel(
            key: const Key('Food wheel'),
            selected: _cubit!.wheelController.stream,
            duration: const Duration(seconds: 5),
            alignment: Alignment.centerRight,
            indicators: const [
              FortuneIndicator(
                alignment: Alignment.centerRight,
                child: TriangleIndicator(
                  color: Colors.red,
                ),
              ),
            ],
            animateFirst: false,
            physics: NoPanPhysics(),
            onAnimationEnd: () {
              _cubit!.onSpinAnimEnd();
            },
            items: foods.map((e) => FortuneItem(child: Text(e.name))).toList(),
          ),
        );
      },
    );
  }

  Widget _filters() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Wrap(
        spacing: 6,
        runSpacing: 6,
        children: _cubit!.currentFilterMap.keys.map((e) {
          final isSelected = _cubit!.currentFilterMap[e];
          return ChoiceChip(
            label: Text(e),
            selectedColor: Colors.blue,
            labelStyle:
                TextStyle(color: isSelected ? Colors.white : Colors.grey),
            selected: isSelected,
            onSelected: (newBoolValue) {
              _cubit?.onChangeFilter(e, newBoolValue);
            },
          );
        }).toList(),
      ),
    );
  }
}
