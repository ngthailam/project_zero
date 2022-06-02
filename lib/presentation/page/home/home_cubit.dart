import 'dart:async';
import 'dart:math';

import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._allFoodInteractor) : super(HomeLoadingState());

  final ObserveAllFoodInteractor _allFoodInteractor;

  StreamController<int> wheelController = StreamController<int>();
  StreamSubscription? _foodStreamSubscription;

  void initialize() async {
    final stream = await _allFoodInteractor.execute(null);
    _foodStreamSubscription = stream.listen((foodList) {
      emit(HomePrimaryState(foods: foodList, pickedFood: state.pickedFood));
    });
  }

  void onPickedFood(int index) {
    if (state.foods?.isNotEmpty != true) return;
    final pickedFood = state.foods![index];
    emit(HomePrimaryState(foods: state.foods, pickedFood: pickedFood));
  }

  Food? _pickedFood;

  void onSpinAnimEnd() {
    emit(HomePrimaryState(foods: state.foods, pickedFood: _pickedFood));
  }

  void onSpin() {
    Random random = Random();
    int randomNumber = random.nextInt(state.foods!.length);
    _pickedFood = state.foods![randomNumber];
    wheelController.add(randomNumber);
  }

  void manualDispose() {
    _foodStreamSubscription?.cancel();
  }
}
