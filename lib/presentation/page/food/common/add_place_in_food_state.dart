import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/utils/load_state.dart';

part 'add_place_in_food_state.g.dart';

@CopyWith()
class AddPlaceInFoodState {
  final List<Place>? places;
  final LoadState addPlaceLoadState;

  AddPlaceInFoodState({this.places, this.addPlaceLoadState = LoadState.none});
}
