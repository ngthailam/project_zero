import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/food/search_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/add_food_in_place_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/page/place/common/add_food_in_place_state.dart';
import 'package:de1_mobile_friends/utils/load_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFoodInPlaceCubit extends Cubit<AddFoodInPlaceState> {
  AddFoodInPlaceCubit(
    this._addFoodInPlaceInteractor,
    this._searchFoodInteractor,
  ) : super(AddFoodInPlaceState());

  final AddFoodInPlaceInteractor _addFoodInPlaceInteractor;
  final SearchFoodInteractor _searchFoodInteractor;

  Timer? _debounce;

  void searchFoods(String keyword) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await _searchFoodInteractor.execute(keyword);
      emit(state.copyWith(foods: results));
    });
  }

  void manualDispose() {
    _debounce?.cancel();
  }

  void addFoodInPlace(Food? pickedFood, String placeId) async {
    if (pickedFood == null) return;
    emit(state.copyWith(addFoodLoadState: LoadState.loading));
    try {
      await _addFoodInPlaceInteractor.execute(AddFoodInPlaceInput(
        foodId: pickedFood.id,
        placeId: placeId,
      ));
      emit(state.copyWith(addFoodLoadState: LoadState.success));
    } on Exception catch (_) {
      emit(state.copyWith(addFoodLoadState: LoadState.failure));
    }
  }
}
