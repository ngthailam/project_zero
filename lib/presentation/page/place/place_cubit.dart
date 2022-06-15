import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/place/delete_place_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/get_places_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/observe_places_interactor.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(
    this._observePlaceInteractor,
    this._getPlaceInteractor,
    this._deletePlaceInteractor,
  ) : super(PlacePrimaryState());

  final ObservePlacesInteractor _observePlaceInteractor;
  final GetPlacesInteractor _getPlaceInteractor;
  final DeletePlaceInteractor _deletePlaceInteractor;

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
}
