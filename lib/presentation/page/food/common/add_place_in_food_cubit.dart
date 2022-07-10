import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/food/add_place_in_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/search_place_interactor.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/presentation/page/food/common/add_place_in_food_state.dart';
import 'package:de1_mobile_friends/utils/load_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddPlaceInFoodCubit extends Cubit<AddPlaceInFoodState> {
  AddPlaceInFoodCubit(
    this._searchPlaceInteractor,
    this._addPlaceInFoodInteractor,
  ) : super(AddPlaceInFoodState());

  final SearchPlaceInteractor _searchPlaceInteractor;
  final AddPlaceInFoodInteractor _addPlaceInFoodInteractor;

  Timer? _debounce;

  void searchPlaces(String keyword) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await _searchPlaceInteractor.execute(keyword);
      emit(state.copyWith(places: results));
    });
  }

  void manualDispose() {
    _debounce?.cancel();
  }

  void addPlaceInFood(Place? pickedPlace, String foodId) async {
    if (pickedPlace == null) return;
    emit(state.copyWith(addPlaceLoadState: LoadState.loading));
    try {
      await _addPlaceInFoodInteractor.execute(AddPlaceInFoodInput(
        foodId: foodId,
        placeId: pickedPlace.id,
      ));
      emit(state.copyWith(addPlaceLoadState: LoadState.success));
    } on Exception catch (_) {
      emit(state.copyWith(addPlaceLoadState: LoadState.failure));
    }
  }
}
