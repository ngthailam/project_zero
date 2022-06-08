import 'package:confetti/confetti.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/home_page_medium.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/home_page_small.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocProvider<HomeCubit>(
        create: (context) => _cubit!..initialize(),
        child: isMobile(context)
            ? HomePageSmall(
                confettiController: _confettiController!,
              )
            : HomePageMedium(
                confettiController: _confettiController!,
              ),
      ),
    );
  }
}
