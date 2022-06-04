import 'dart:async';
import 'dart:math';

import 'package:de1_mobile_friends/domain/interactor/config/get_all_config_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/model/config.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_state.dart';
import 'package:de1_mobile_friends/tuAI/tu_ai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._allFoodInteractor,
    this._tuAi,
    this._getConfigInteractor,
  ) : super(HomeLoadingState());

  final ObserveAllFoodInteractor _allFoodInteractor;
  final GetConfigInteractor _getConfigInteractor;
  final TuAi _tuAi;

  Config _config = Config();
  StreamController<int> wheelController = StreamController<int>();
  StreamSubscription? _foodStreamSubscription;

  void initialize() {
    _initTuAi();
    _observeFoods();
  }

  void _initTuAi() async {
    _config = await _getConfigInteractor.execute(null);
    final output = _tuAi.suggestFoodType(TuAiInput(
      temp: _config.temp,
    ));
    // emit result
    emit(HomePrimaryState(
      foods: state.foods,
      pickedFood: state.pickedFood,
      tuAiOutput: output,
    ));
  }

  void _observeFoods() async {
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
