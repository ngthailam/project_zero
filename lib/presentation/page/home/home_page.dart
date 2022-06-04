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
        ConfettiController(duration: const Duration(milliseconds: 1000));
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
            Text(
              "What to eat for lunch? Spin the wheel!!!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 52),
            BlocProvider<HomeCubit>(
              create: (context) => _cubit!..initialize(),
              child: Row(
                children: [
                  Expanded(child: _foodWheel()),
                  const SizedBox(width: 32),
                  Expanded(child: _rightSide()),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.foodManage);
              },
              child: Text("Edit foods"),
            )
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
        TuAiWidget(),
      ],
    );
  }

  Widget _result() {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state.pickedFood != null) {
        _confettiController?.play();
      }
    }, builder: (context, state) {
      if (state.pickedFood != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("You have spinned:"),
            const SizedBox(height: 24),
            Text(
              state.pickedFood!.name.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ConfettiWidget(
              confettiController: _confettiController!,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 20,
              maxBlastForce: 60,
              minBlastForce: 50,
              gravity: 0.3,
            ),
            ConfettiWidget(
              confettiController: _confettiController!,
              blastDirection: -pi / 3,
              emissionFrequency: 0.02,
              numberOfParticles: 25,
              maxBlastForce: 50,
              minBlastForce: 30,
              gravity: 0.3,
            ),
            ConfettiWidget(
              confettiController: _confettiController!,
              blastDirection: -pi / 0.5,
              emissionFrequency: 0.02,
              numberOfParticles: 20,
              maxBlastForce: 50,
              minBlastForce: 40,
              gravity: 0.3,
            )
          ],
        );
      }

      return SizedBox.shrink();
    });
  }

  Widget _foodWheel() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // Do something, remove if not needed
      },
      builder: (context, state) {
        final foods = state.foods;

        if (foods?.isNotEmpty != true) {
          return Text("Something went wrong");
        }

        if (foods!.length == 1) {
          return Text("Only 1 option: ${foods[0].name}");
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: FortuneWheel(
                key: Key('Food wheel'),
                selected: _cubit!.wheelController.stream,
                duration: Duration(seconds: 5),
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
                items:
                    foods.map((e) => FortuneItem(child: Text(e.name))).toList(),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _cubit!.onSpin();
              },
              child: Text("Spin"),
            ),
          ],
        );
      },
    );
  }
}
