import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/food/add_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/delete_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/occasion/get_occasions_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodManageCubit extends Cubit<FoodManageState> {
  FoodManageCubit(
    this._allFoodInteractor,
    this._addFoodInteractor,
    this._deleteFoodInteractor,
    this._getOccasionInteractor,
  ) : super(FoodManageInitialState());

  final ObserveAllFoodInteractor _allFoodInteractor;
  final AddFoodInteractor _addFoodInteractor;
  final DeleteFoodInteractor _deleteFoodInteractor;
  final GetOccasionInteractor _getOccasionInteractor;

  StreamSubscription? _foodStreamSubscription;
  FoodType _currentFoodType = FoodType();

  void initialize() async {
    _getOccasion();
    final stream = await _allFoodInteractor.execute(null);
    _foodStreamSubscription = stream.listen((foods) {
      emit(FoodManagePrimaryState(foods: foods, occasion: state.occasion));
    });
  }

  void _getOccasion() {
    _getOccasionInteractor.execute(null).then((value) {
      emit(FoodManagePrimaryState(foods: state.foods, occasion: value));
    }).catchError((e) {
      // do nothing for now
    });
  }

  void addFood(String? foodName) async {
    if (foodName?.isNotEmpty != true) {
      return;
    }
    final input = AddFoodInput(
      name: foodName!,
      type: _currentFoodType,
      occasion: state.occasion,
    );
    final result = await _addFoodInteractor.execute(input);
    if (result.isSuccess()) {
      // Do nothing, already observe results
      // TODO: should show success dialog or smt here
    } else {
      // emit(FoodManageErrorState(result.exception!));
    }
  }

  void editFood(String? id, String foodName) async {
    if (foodName.isEmpty) {
      return;
    }

    final input = AddFoodInput(
      id: id,
      name: foodName,
      type: _currentFoodType,
      occasion: state.occasion,
    );
    final result = await _addFoodInteractor.execute(input);
    if (result.isSuccess()) {
      // Do nothing, already observe results
      // TODO: should show success dialog or smt here
    } else {
      // emit(FoodManageErrorState(result.exception!));
    }
  }

  void deleteFood(String id) async {
    final result = await _deleteFoodInteractor.execute(id);
    if (result.isSuccess()) {
      // Do nothing, already observe results
    } else {
      // emit(FoodManageErrorState(result.exception!));
    }
  }

  void onChangedType(FoodType type) {
    _currentFoodType = type;
  }

  void disposeManual() {
    _foodStreamSubscription?.cancel();
  }

  void onPickOccasion(Occasion occasion) {
    emit(FoodManagePrimaryState(foods: state.foods, occasion: occasion));
  }
}
