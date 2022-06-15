import 'package:de1_mobile_friends/domain/model/place.dart';

abstract class PlaceDetailState {}

class PlaceDetailLoadingState extends PlaceDetailState {}

class PlaceDetailPrimaryState extends PlaceDetailState {
  final Place? place;

  PlaceDetailPrimaryState({this.place});
}

class PlaceDetailErrorState extends PlaceDetailState {
  final Exception e;

  PlaceDetailErrorState(this.e);
}
