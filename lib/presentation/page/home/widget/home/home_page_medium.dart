import 'package:de1_mobile_friends/presentation/page/home/bloc/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/bloc/home_state.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/common/food_wheel.dart';
import 'package:de1_mobile_friends/presentation/utils/constants.dart';
import 'package:de1_mobile_friends/presentation/widget/slide_up_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageMedium extends StatefulWidget {
  const HomePageMedium({
    Key? key,
  }) : super(key: key);

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
  void dispose() {
    _cubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state.foods?.isNotEmpty != true) {
          return const Center(
            child: Text('Something went wrong, please reload page'),
          );
        }

        if (state.occasions?.occasions.isNotEmpty == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _welcome(),
              _occasionText(state),
              const SizedBox(height: 16),
              _spinner(),
              const SizedBox(height: 16),
              _instruction(),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _welcome() {
    return SlideUp(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to ',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: isMobile(context) ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/img/logo.png',
            height: isMobile(context) ? 80 : 120,
            width: isMobile(context) ? 80 : 120,
          ),
        ],
      ),
    );
  }

  Widget _occasionText(HomeState state) {
    return SlideUp(
      delay: const Duration(milliseconds: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'What\'s the occasion ?',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: isMobile(context) ? 16 : 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 16),
          _occasionDropDown(state),
        ],
      ),
    );
  }

  Widget _occasionDropDown(HomeState state) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        customButton: Text(
          state.getPickedOccasionText ?? '',
          style: _occasionTextStyle,
        ),
        onChanged: (String? value) {
          _cubit?.onOccasionSelected(value);
        },
        focusColor: Colors.transparent,
        dropdownWidth: 160,
        items: state.occasions!.occasions.keys.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(
              state.occasions!.occasions[e] ?? '',
              style: _occasionTextStyle.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
        dropdownElevation: 8,
      ),
    );
  }

  TextStyle get _occasionTextStyle => const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF093684),
      );

  Widget _spinner() {
    return SlideUp(
      delay: const Duration(milliseconds: 400),
      beginOffset: 0.1,
      child: FoodWheel(
        onSpinEnd: () {
          _cubit?.onSpinEnd();
        },
      ),
    );
  }

  Widget _instruction() {
    return const SlideUp(
      delay: Duration(milliseconds: 600),
      child: Text(
        '(Click on card to spin)',
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 16,
          color: Colors.black45,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
