import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/presentation/page/home/bloc/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/food_wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageSmall extends StatefulWidget {
  const HomePageSmall({Key? key, })
      : super(key: key);


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
              FoodWheel(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                onSpinEnd: () => _cubit!.onSpinEnd(),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.foodManage);
                },
                child: const Text("Edit foods"),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
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
