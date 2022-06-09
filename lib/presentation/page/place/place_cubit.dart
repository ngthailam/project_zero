import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/place/add_place_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/get_places_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/observe_place_interactor.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(
    this._observePlaceInteractor,
    this._addPlaceInteractor,
    this._getPlaceInteractor,
  ) : super(PlacePrimaryState());

  final ObservePlaceInteractor _observePlaceInteractor;
  final AddPlaceInteractor _addPlaceInteractor;
  final GetPlacesInteractor _getPlaceInteractor;

  StreamSubscription? _placeStreamSub;

  void initialze() async {
    final places = await _getPlaceInteractor.execute(null);
    emit(PlacePrimaryState(places: places));

    _placeStreamSub = _observePlaceInteractor.execute(null).listen((places) {
      emit(PlacePrimaryState(places: places));
    });
  }

  void addPlace() {
    // do things here
  }

  void manualDispose() {
    _placeStreamSub?.cancel();
    _placeStreamSub = null;
  }
}
