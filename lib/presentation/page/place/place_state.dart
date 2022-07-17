import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';

part 'place_state.g.dart';

@CopyWith()
class PlaceState {
  final List<Place>? places;
  final List<Place> displayedPlaces;
  final String searchKeyword;

  PlaceState({
    this.places,
    this.displayedPlaces = const [],
    this.searchKeyword = '',
  });
}
