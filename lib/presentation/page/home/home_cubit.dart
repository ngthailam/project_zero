import 'dart:async';
import 'dart:math';

import 'package:de1_mobile_friends/domain/interactor/config/get_all_config_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/model/config.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
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
  StreamController<int> wheelController = StreamController<int>.broadcast();
  StreamSubscription? _foodStreamSubscription;
  Map<String, dynamic> currentFilterMap = FoodType.allTrue().toJson();
  List<Food> _originalFoodList = [];

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
    if (_foodStreamSubscription != null) return;
    final stream = await _allFoodInteractor.execute(null);

    // begin subscription
    _foodStreamSubscription = stream.listen((foodList) {
      _originalFoodList = foodList;

      _emitFoodListWithFilter();
    });
  }

  void onPickedFood(int index) {
    if (state.foods?.isNotEmpty != true) return;
    final pickedFood = state.foods![index];
    emit(HomePrimaryState(foods: state.foods, pickedFood: pickedFood));
  }

  Food? _pickedFood;
  Food? _foodResultTemp;

  void onSpinAnimEnd() {
    emit((state as HomePrimaryState).copyWith(pickedFood: _pickedFood, foodResultTemp: _foodResultTemp));
  }

  void onSpin() {
    Random random = Random();
    int randomNumber = random.nextInt(state.foods!.length);
    _pickedFood = state.foods![randomNumber];
    if (_foodResultTemp == null || _foodResultTemp != _pickedFood) {
      _foodResultTemp = _pickedFood;
    }
    wheelController.add(randomNumber);
  }

  void manualDispose() {
    _foodStreamSubscription?.cancel();
  }

  onChangeFilterAll(FoodType type) {
    currentFilterMap = type.toJson();
    _emitFoodListWithFilter();
  }

  void onChangeFilter(String e, bool newBoolValue) {
    currentFilterMap[e] = newBoolValue;
    _emitFoodListWithFilter();
  }

  void _emitFoodListWithFilter() {
    // prepare filter that is false
    Map<String, bool> falseOnlyMap = {};
    for (var element in currentFilterMap.entries) {
      if (element.value == false) {
        falseOnlyMap[element.key] = false;
      }
    }
    // apply filter
    List<Food> filteredFoodList = [];

    if (falseOnlyMap.isEmpty) {
      filteredFoodList = _originalFoodList;
    } else {
      filteredFoodList = _originalFoodList.where((foodElement) {
        final foodElementType = foodElement.type!.toJson();

        var isValid = true;
        for (var typeElement in foodElementType.keys) {
          if (falseOnlyMap[typeElement] == false &&
              foodElementType[typeElement] != false) {
            isValid = false;
          }
        }

        return isValid;
      }).toList();
    }

    // emit result
    emit(
      HomePrimaryState(foods: filteredFoodList, pickedFood: state.pickedFood),
    );
  }
}
