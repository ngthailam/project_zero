import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/food/add_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/delete_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/get_food_categories_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/observe_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/occasion/get_occasions_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodManageCubit extends Cubit<FoodManageState> {
  FoodManageCubit(
    this._allFoodInteractor,
    this._addFoodInteractor,
    this._deleteFoodInteractor,
    this._getOccasionInteractor,
    this._getFoodCategoriesInteractor,
  ) : super(FoodManageState());

  final ObserveAllFoodInteractor _allFoodInteractor;
  final AddFoodInteractor _addFoodInteractor;
  final DeleteFoodInteractor _deleteFoodInteractor;
  // ignore: unused_field
  final GetOccasionInteractor _getOccasionInteractor;
  final GetFoodCategoriesInteractor _getFoodCategoriesInteractor;

  StreamSubscription? _foodStreamSubscription;

  Map<String, String> _categories = {};
  Map<String, String> get getCategories => _categories;

  void initialize() async {
    _categories = await _getFoodCategoriesInteractor.execute(null);
    final stream = await _allFoodInteractor.execute(null);
    _foodStreamSubscription = stream.listen((List<Food> foods) {
      final filteredFoodList = state.searchKeyword.isNotEmpty
          ? searchInFoods(
              text: state.searchKeyword,
              foods: foods,
            )
          : foods;

      final Map<String, List<Food>> foodGrouppedByCategory =
          foodListToFoodGrouppedByCategory(filteredFoodList);

      emit(state.copyWith(
        foods: foods,
        displayedFoods: foodGrouppedByCategory,
        occasion: state.occasion,
      ));
    });
  }

  void addFood(String? foodName, Map<String, bool> foodCategories) async {
    if (foodName?.isNotEmpty != true) {
      return;
    }
    final input = AddFoodInput(
      name: foodName!,
      occasion: state.occasion,
      categories: foodCategories,
    );
    final result = await _addFoodInteractor.execute(input);
    if (result.isSuccess()) {
      // Do nothing, already observe results
      // TODO: should show success dialog or smt here
    } else {
      // emit(FoodManageErrorState(result.exception!));
    }
  }

  void editFood(
    String? id,
    String foodName,
    Map<String, bool> foodCategories,
  ) async {
    if (foodName.isEmpty) {
      return;
    }

    final input = AddFoodInput(
      id: id,
      name: foodName,
      occasion: state.occasion,
      categories: foodCategories,
    );
    final result = await _addFoodInteractor.execute(input);
    if (result.isSuccess()) {
      // Do nothing, already observe results
      // TODO: should show success dialog or smt here
    } else {
      // emit(FoodManageErrorState(result.exception!));
    }
  }

  void deleteFood(String id) async {
    final result = await _deleteFoodInteractor.execute(id);
    if (result.isSuccess()) {
      // Do nothing, already observe results
    } else {
      // emit(FoodManageErrorState(result.exception!));
    }
  }

  void disposeManual() {
    _foodStreamSubscription?.cancel();
  }

  void searchFood(String text) {
    // Do in place search
    if (state.foods?.isNotEmpty != true) return;
    final originalData = searchInFoods(text: text, foods: state.foods!);
    final Map<String, List<Food>> foodGrouppedByCategory =
        foodListToFoodGrouppedByCategory(originalData);

    emit(state.copyWith(
      displayedFoods: foodGrouppedByCategory,
      occasion: state.occasion,
      searchKeyword: text,
    ));
  }

  Map<String, List<Food>> foodListToFoodGrouppedByCategory(List<Food> foods) {
    final Map<String, List<Food>> foodGrouppedByCategory = {'none': []};

    for (var food in foods) {
      if (food.categories?.isNotEmpty == true) {
        food.categories?.forEach((key, value) {
          if (foodGrouppedByCategory[key] == null) {
            foodGrouppedByCategory[key] = [food];
          } else {
            foodGrouppedByCategory[key]!.add(food);
          }
        });
      } else {
        foodGrouppedByCategory['none']?.add(food);
      }
    }
    return foodGrouppedByCategory;
  }

  List<Food> searchInFoods({required String text, required List<Food> foods}) {
    return foods
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}
