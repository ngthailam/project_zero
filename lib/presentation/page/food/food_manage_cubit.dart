import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodManageCubit extends Cubit<FoodManageState> {
  FoodManageCubit(
    this._allFoodInteractor,
  ) : super(FoodManageInitialState());

  final ObserveAllFoodInteractor _allFoodInteractor;

  void initialize() async {
    final stream = await _allFoodInteractor.execute(null);
    stream.listen((foodList) {
      emit(FoodManagePrimaryState(foodList));
    });
  }
}
