import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';

part 'home_state.g.dart';

enum HomeSpinStatus { normal, spinning, spinEnd }

extension HomeSpinStatusExt on HomeSpinStatus {
  bool isSpinning() => this == HomeSpinStatus.spinning;
  bool isSpinEnd() => this == HomeSpinStatus.spinEnd;
}

@CopyWith()
class HomeState {
  final List<Food>? foods;
  final List<Food>? displayedFoods;
  final Occasion? occasions;
  final String? pickedOccasionKey;
  final HomeSpinStatus spinStatus;
  final int? pickedFoodIndex;

  HomeState({
    this.foods,
    this.displayedFoods,
    this.occasions,
    this.pickedOccasionKey,
    this.spinStatus = HomeSpinStatus.normal,
    this.pickedFoodIndex,
  });

  String? get getPickedOccasionText {
    if (pickedOccasionKey == null) return null;
    return occasions!.occasions[pickedOccasionKey];
  }

  Food? get getPickedFood {
    if (pickedFoodIndex == null) return null;
    return displayedFoods?[pickedFoodIndex!];
  }
}
