// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/repo/food_repo_impl.dart' as _i4;
import 'domain/interactor/food/add_food_interactor.dart' as _i7;
import 'domain/interactor/food/delete_food_interactor.dart' as _i8;
import 'domain/interactor/food/get_all_food_interactor.dart' as _i5;
import 'domain/interactor/food/observe_all_food_interactor.dart' as _i6;
import 'domain/repo/food_repo.dart' as _i3;
import 'presentation/page/food/food_manage_cubit.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.FoodRepo>(() => _i4.FoodRepoImpl());
  gh.factory<_i5.GetAllFoodInteractor>(
      () => _i5.GetAllFoodInteractor(get<_i3.FoodRepo>()));
  gh.factory<_i6.ObserveAllFoodInteractor>(
      () => _i6.ObserveAllFoodInteractor(get<_i3.FoodRepo>()));
  gh.factory<_i7.AddFoodInteractor>(
      () => _i7.AddFoodInteractor(get<_i3.FoodRepo>()));
  gh.factory<_i8.DeleteFoodInteractor>(
      () => _i8.DeleteFoodInteractor(get<_i3.FoodRepo>()));
  gh.factory<_i9.FoodManageCubit>(() => _i9.FoodManageCubit(
      get<_i6.ObserveAllFoodInteractor>(),
      get<_i7.AddFoodInteractor>(),
      get<_i8.DeleteFoodInteractor>()));
  return get;
}
