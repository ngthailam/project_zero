import 'dart:async';
import 'dart:math';

import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/occasion/get_occasions_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
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
      emitWithOccasionFilter(state.pickedOccasionKey, foodList);
    });
  }

  void onSpinEnd() {
    emit(state.copyWith(spinStatus: HomeSpinStatus.spinEnd));
  }

  void onSpin() {
    Random random = Random();
    int randomNumber = random.nextInt(state.displayedFoods!.length);
    emit(state.copyWith(
      spinStatus: HomeSpinStatus.spinning,
      pickedFoodIndex: randomNumber,
    ));
  }

  void manualDispose() {
    _foodStreamSubscription?.cancel();
  }

  void emitWithOccasionFilter(String? occasionKey, List<Food> foodList) {
    if (state.pickedOccasionKey == null) return;

    final displayedFoods = foodList.where((element) {
      return element.occasion?[occasionKey] != null;
    }).toList();
    emit(state.copyWith(
      foods: foodList,
      displayedFoods: displayedFoods,
      pickedOccasionKey: occasionKey,
    ));
  }

  void onOccasionSelected(String? occasionKey) {
    if (occasionKey == state.pickedOccasionKey) return;
    emitWithOccasionFilter(occasionKey, state.foods ?? []);
  }
}
