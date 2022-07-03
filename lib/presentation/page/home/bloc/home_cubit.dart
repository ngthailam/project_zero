import 'dart:async';
import 'dart:math';

import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/occasion/get_occasions_interactor.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/presentation/page/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._allFoodInteractor,
    this._getOccasionInteractor,
  ) : super(HomeState());

  final ObserveAllFoodInteractor _allFoodInteractor;
  final GetOccasionInteractor _getOccasionInteractor;

  StreamSubscription? _foodStreamSubscription;

  Future initialize() async {
    final occasions = await _getOccasionInteractor.execute(null);
    emit(state.copyWith(
        occasions: occasions,
        pickedOccasionKey: occasions.occasions.keys.first));

    _initializeFoods();
  }

  Future _initializeFoods() async {
    if (_foodStreamSubscription != null) return;
    final stream = await _allFoodInteractor.execute(null);

    _foodStreamSubscription = stream.listen((foodList) {
      emit(state.copyWith(foods: foodList, displayedFoods: foodList));
    });
  }

  void onSpinEnd() {
    emit(state.copyWith(spinStatus: HomeSpinStatus.spinEnd));
  }

  void onSpin() {
    Random random = Random();
    int randomNumber = random.nextInt(state.foods!.length);
    emit(state.copyWith(
      spinStatus: HomeSpinStatus.spinning,
      pickedFoodIndex: randomNumber,
    ));
  }

  void manualDispose() {
    _foodStreamSubscription?.cancel();
  }

  void _emitFoodListWithFilter({Occasion? occasion}) {
    // prepare filter that is false
    // Map<String, bool> falseOnlyMap = {};
    // for (var element in currentFilterMap.entries) {
    //   if (element.value == false) {
    //     falseOnlyMap[element.key] = false;
    //   }
    // }
    // // apply filter
    // List<Food> filteredFoodList = [];

    // if (falseOnlyMap.isEmpty) {
    //   filteredFoodList = _originalFoodList;
    // } else {
    //   filteredFoodList = _originalFoodList.where((foodElement) {
    //     final foodElementType = foodElement.type!.toJson();

    //     var isValid = true;
    //     for (var typeElement in foodElementType.keys) {
    //       if (falseOnlyMap[typeElement] == false &&
    //           foodElementType[typeElement] != false) {
    //         isValid = false;
    //       }
    //     }

    //     return isValid;
    //   }).toList();
    // }

    // if (occasion != null) {
    //   filteredFoodList = filteredFoodList.where((element) {
    //     var isValid = true;

    //     final foodOccasion = element.occasion;

    //     if (foodOccasion?.isNotEmpty == true) {
    //       occasion.occasions.forEach((key, value) {
    //         final foodOccasionWithKey = foodOccasion![key];
    //         if (isValid != false) {
    //           isValid =
    //               foodOccasionWithKey != null && foodOccasionWithKey == value;
    //         }
    //       });
    //     } else {
    //       // default will be included anyways
    //       isValid = true;
    //     }

    //     return isValid;
    //   }).toList();
    // }

    // emit result
    // emit(
    //   HomePrimaryState(
    //     foods: filteredFoodList,
    //     pickedFood: state.pickedFood,
    //     occasion: occasion ?? state.occasions,
    //   ),
    // );
  }

  void onOccasionSelected(String? occasionKey) {
    if (occasionKey == state.pickedOccasionKey) return;
    emit(state.copyWith(pickedOccasionKey: occasionKey));
  }
}
