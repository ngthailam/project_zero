import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/place/delete_place_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/get_places_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/observe_places_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/place_foods_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
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
  ) : super(PlaceState());

  final ObservePlacesInteractor _observePlaceInteractor;
  final GetPlacesInteractor _getPlaceInteractor;
  final DeletePlaceInteractor _deletePlaceInteractor;
  final PlaceFoodsInteractor _placeFoodsInteractor;

  StreamSubscription? _placeStreamSub;

  void initialze() async {
    final places = await _getPlaceInteractor.execute(null);
    emit(state.copyWith(places: places, displayedPlaces: places));

    _placeStreamSub = _observePlaceInteractor.execute(null).listen((places) {
      final filteredPlaces = state.searchKeyword.isNotEmpty
          ? searchPlaceByName(places: places, text: state.searchKeyword)
          : places;
      emit(state.copyWith(places: filteredPlaces));
    });
  }

  void manualDispose() {
    _placeStreamSub?.cancel();
    _placeStreamSub = null;
  }

  void deletePlace(String id) async {
    try {
      await _deletePlaceInteractor.execute(id);
    } on Exception catch (_) {
      // handle error
    }
  }

  void searchPlace(String text) {
    if (state.places?.isNotEmpty != true) return;
    final displayedPlaces = searchPlaceByName(
      text: text,
      places: state.places!,
    );

    emit(state.copyWith(
      displayedPlaces: displayedPlaces,
      searchKeyword: text,
    ));
  }

  void addFoodInPlace({required String placeId, required Food food}) {
    _placeFoodsInteractor.addFoodInPlace(placeId: placeId, foodId: food.id);
  }

  List<Place> searchPlaceByName(
      {required String text, required List<Place> places}) {
    return places
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}
