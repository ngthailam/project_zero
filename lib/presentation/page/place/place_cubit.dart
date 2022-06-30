import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/food/search_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/delete_place_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/get_places_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/observe_places_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/place_foods_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(
    this._observePlaceInteractor,
    this._getPlaceInteractor,
    this._deletePlaceInteractor,
    this._placeFoodsInteractor,
    this._searchFoodInteractor,
  ) : super(PlacePrimaryState());

  final ObservePlacesInteractor _observePlaceInteractor;
  final GetPlacesInteractor _getPlaceInteractor;
  final DeletePlaceInteractor _deletePlaceInteractor;
  final PlaceFoodsInteractor _placeFoodsInteractor;
  final SearchFoodInteractor _searchFoodInteractor;

  StreamSubscription? _placeStreamSub;

  void initialze() async {
    final places = await _getPlaceInteractor.execute(null);
    emit(PlacePrimaryState(places: places));

    _placeStreamSub = _observePlaceInteractor.execute(null).listen((places) {
      emit(PlacePrimaryState(places: places));
    });
  }

  void manualDispose() {
    _placeStreamSub?.cancel();
    _placeStreamSub = null;
  }

  void deletePlace(String id) async {
    try {
      await _deletePlaceInteractor.execute(id);
    } on Exception catch (e) {
      emit(PlaceErrorState(e: e));
    }
  }

  void addFoodInPlace({required String placeId, required Food food}) {
    _placeFoodsInteractor.addFoodInPlace(placeId: placeId, foodId: food.id);
  }

  void searchFood({required String keyword}) async {
    final matchingFoods = await _searchFoodInteractor.execute(keyword);
    emit(PlaceFoodSearchingState(
      keyword: keyword,
      searchResults: matchingFoods,
      places: state.places,
    ));
  }
}
