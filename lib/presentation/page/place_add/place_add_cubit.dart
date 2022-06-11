import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/add_place_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/presentation/page/place_add/place_add_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlaceAddCubit extends Cubit<PlaceAddState> {
  PlaceAddCubit(this._addPlaceInteractor, this._allFoodInteractor)
      : super(PlaceAddPrimaryState());

  final AddPlaceInteractor _addPlaceInteractor;
  final ObserveAllFoodInteractor _allFoodInteractor;

  Place _inputPlace = Place.empty();

  StreamSubscription? _foodStreamSubscription;

  void initialize() async {
    final stream = await _allFoodInteractor.execute(null);
    _foodStreamSubscription = stream.listen((foods) {
      emit(PlaceAddPrimaryState(foods: foods));
    });
  }

  void onNameChanged(String text) {
    _inputPlace = _inputPlace.copyWith(name: text);
  }

  void onDirectionChanged(String text) {
    _inputPlace = _inputPlace.copyWith(direction: text);
  }

  void onFoodOnMenuChanged(List<Food> foods) {
    // impl later
  }

  void addPlace() async {
    if (_inputPlace.name.isEmpty) {
      emit(PlaceAddErrorState(Exception('Invalid name')));
      return;
    }

    try {
      await _addPlaceInteractor.execute(_inputPlace);
      emit(PlaceAddSuccessState());
    } on Exception catch (e) {
      emit(PlaceAddErrorState(Exception(e)));
    }
  }

  void manualDispose() {
    _foodStreamSubscription?.cancel();
    _foodStreamSubscription = null;
  }
}
