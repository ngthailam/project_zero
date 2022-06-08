import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class FoodWheel extends StatefulWidget {
  const FoodWheel({
    Key? key,
    required this.stream,
    required this.onSpinEnd,
    this.height,
    this.width,
  }) : super(key: key);

  final Stream<int> stream;
  final VoidCallback onSpinEnd;
  final double? height;
  final double? width;

  @override
  State<FoodWheel> createState() => _FoodWheelState();
}

class _FoodWheelState extends State<FoodWheel> {
  @override
  Widget build(BuildContext context) {
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
          height: widget.height,
          width: widget.width,
          child: Stack(
            children: [
              FortuneWheel(
                key: const Key('Food wheel'),
                selected: widget.stream,
                duration: const Duration(seconds: 5),
                alignment: Alignment.centerRight,
                animateFirst: false,
                indicators: const [], // Leave as empty list to show no indicators
                physics: NoPanPhysics(),
                onAnimationEnd: widget.onSpinEnd,
                items:
                    foods.map((e) => FortuneItem(child: Text(e.name))).toList(),
              ),
              _spinBtn(),
            ],
          ),
        );
      },
    );
  }

  // There will be a problem with multiple btn click
  Widget _spinBtn() {
    return Center(
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 167, 215, 254)),
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 232, 232, 232)),
        ),
        onPressed: () {
          context.read<HomeCubit>().onSpin();
        },
        child: const Text(
          "Spin",
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
