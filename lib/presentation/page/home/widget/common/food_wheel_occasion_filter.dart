import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_state.dart';
import 'package:de1_mobile_friends/presentation/widget/occasion_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodWheelOccasionFilter extends StatelessWidget {
  const FoodWheelOccasionFilter({
    Key? key,
    required this.onPickOccasion,
  }) : super(key: key);

  final Function(Occasion occasion) onPickOccasion;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Choose occasion'),
        const SizedBox(height: 8),
        BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state is HomePrimaryState && state.occasion != null) {
            return OccasionPicker(
              occasion: state.occasion!,
              onPickOccasion: onPickOccasion,
            );
          }

          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
