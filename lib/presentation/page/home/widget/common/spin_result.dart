import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpinResult extends StatelessWidget {
  const SpinResult({Key? key, required this.controller}) : super(key: key);

  final ConfettiController controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // Using like this may cause some problem on multiple state update
      if (state.foodResultTemp != null) {
        controller.play();
      }
    }, builder: (context, state) {
      if (state.pickedFood != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 24),
            ..._confettis(),
          ],
        );
      }

      return const SizedBox.shrink();
    });
  }

  List<Widget> _confettis() {
    return [
      ConfettiWidget(
        confettiController: controller,
        blastDirection: -pi / 2,
        emissionFrequency: 0.0001,
        numberOfParticles: 10,
        gravity: 0.3,
      ),
      ConfettiWidget(
        confettiController: controller,
        blastDirection: -pi / 4,
        emissionFrequency: 0.0001,
        numberOfParticles: 10,
        gravity: 0.3,
      ),
      ConfettiWidget(
        confettiController: controller,
        blastDirection: -3 * pi / 4,
        emissionFrequency: 0.0001,
        numberOfParticles: 10,
        gravity: 0.3,
      )
    ];
  }
}
