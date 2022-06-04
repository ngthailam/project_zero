// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/repo/config_repo_impl.dart' as _i4;
import 'data/repo/food_repo_impl.dart' as _i6;
import 'domain/interactor/config/get_all_config_interactor.dart' as _i8;
import 'domain/interactor/food/add_food_interactor.dart' as _i11;
import 'domain/interactor/food/delete_food_interactor.dart' as _i12;
import 'domain/interactor/food/get_all_food_interactor.dart' as _i7;
import 'domain/interactor/food/observe_all_food_interactor.dart' as _i9;
import 'domain/repo/config_repo.dart' as _i3;
import 'domain/repo/food_repo.dart' as _i5;
import 'presentation/page/food/food_manage_cubit.dart' as _i13;
import 'presentation/page/home/home_cubit.dart' as _i14;
import 'tuAI/tu_ai.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ConfigRepo>(() => _i4.ConfigRepoImpl());
  gh.factory<_i5.FoodRepo>(() => _i6.FoodRepoImpl());
  gh.factory<_i7.GetAllFoodInteractor>(
      () => _i7.GetAllFoodInteractor(get<_i5.FoodRepo>()));
  gh.factory<_i8.GetConfigInteractor>(
      () => _i8.GetConfigInteractor(get<_i3.ConfigRepo>()));
  gh.factory<_i9.ObserveAllFoodInteractor>(
      () => _i9.ObserveAllFoodInteractor(get<_i5.FoodRepo>()));
  gh.singleton<_i10.TuAi>(_i10.TuAiImpl());
  gh.factory<_i11.AddFoodInteractor>(
      () => _i11.AddFoodInteractor(get<_i5.FoodRepo>()));
  gh.factory<_i12.DeleteFoodInteractor>(
      () => _i12.DeleteFoodInteractor(get<_i5.FoodRepo>()));
  gh.factory<_i13.FoodManageCubit>(() => _i13.FoodManageCubit(
      get<_i9.ObserveAllFoodInteractor>(),
      get<_i11.AddFoodInteractor>(),
      get<_i12.DeleteFoodInteractor>()));
  gh.factory<_i14.HomeCubit>(() => _i14.HomeCubit(
      get<_i9.ObserveAllFoodInteractor>(),
      get<_i10.TuAi>(),
      get<_i8.GetConfigInteractor>()));
  return get;
}
