// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/client/weather_client.dart' as _i12;
import 'data/config_client/dio_client.dart' as _i5;
import 'data/repo/config_repo_impl.dart' as _i4;
import 'data/repo/food_repo_impl.dart' as _i7;
import 'data/repo/weather_repo_impl.dart' as _i14;
import 'domain/interactor/config/get_all_config_interactor.dart' as _i9;
import 'domain/interactor/food/add_food_interactor.dart' as _i15;
import 'domain/interactor/food/delete_food_interactor.dart' as _i18;
import 'domain/interactor/food/get_all_food_interactor.dart' as _i8;
import 'domain/interactor/food/observe_all_food_interactor.dart' as _i10;
import 'domain/interactor/weather/add_temp_interactor.dart' as _i16;
import 'domain/interactor/weather/add_weather_interactor.dart' as _i17;
import 'domain/interactor/weather/get_weather_interactor.dart' as _i20;
import 'domain/repo/config_repo.dart' as _i3;
import 'domain/repo/food_repo.dart' as _i6;
import 'domain/repo/weather_repo.dart' as _i13;
import 'presentation/page/food/food_manage_cubit.dart' as _i19;
import 'presentation/page/home/home_cubit.dart' as _i21;
import 'tuAI/tu_ai.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModuleX = _$RegisterModuleX();
  gh.factory<_i3.ConfigRepo>(() => _i4.ConfigRepoImpl());
  gh.singleton<_i5.DioClient>(_i5.DioClient());
  gh.factory<_i6.FoodRepo>(() => _i7.FoodRepoImpl());
  gh.factory<_i8.GetAllFoodInteractor>(
      () => _i8.GetAllFoodInteractor(get<_i6.FoodRepo>()));
  gh.factory<_i9.GetConfigInteractor>(
      () => _i9.GetConfigInteractor(get<_i3.ConfigRepo>()));
  gh.factory<_i10.ObserveAllFoodInteractor>(
      () => _i10.ObserveAllFoodInteractor(get<_i6.FoodRepo>()));
  gh.singleton<_i11.TuAi>(_i11.TuAiImpl());
  gh.factory<_i12.WeatherClient>(
      () => registerModuleX.getService(get<_i5.DioClient>()));
  gh.factory<_i13.WeatherRepo>(() => _i14.WeatherRepoImpl());
  gh.factory<_i15.AddFoodInteractor>(
      () => _i15.AddFoodInteractor(get<_i6.FoodRepo>()));
  gh.factory<_i16.AddTempInteractor>(
      () => _i16.AddTempInteractor(get<_i13.WeatherRepo>()));
  gh.factory<_i17.AddWeatherInteractor>(
      () => _i17.AddWeatherInteractor(get<_i13.WeatherRepo>()));
  gh.factory<_i18.DeleteFoodInteractor>(
      () => _i18.DeleteFoodInteractor(get<_i6.FoodRepo>()));
  gh.factory<_i19.FoodManageCubit>(() => _i19.FoodManageCubit(
      get<_i10.ObserveAllFoodInteractor>(),
      get<_i15.AddFoodInteractor>(),
      get<_i18.DeleteFoodInteractor>()));
  gh.factory<_i20.GetWeatherInteractor>(
      () => _i20.GetWeatherInteractor(get<_i13.WeatherRepo>()));
  gh.factory<_i21.HomeCubit>(() => _i21.HomeCubit(
      get<_i10.ObserveAllFoodInteractor>(),
      get<_i11.TuAi>(),
      get<_i9.GetConfigInteractor>(),
      get<_i20.GetWeatherInteractor>(),
      get<_i16.AddTempInteractor>(),
      get<_i17.AddWeatherInteractor>()));
  return get;
}

class _$RegisterModuleX extends _i12.RegisterModuleX {}
