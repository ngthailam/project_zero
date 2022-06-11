// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/config/config_repo_impl.dart' as _i4;
import 'data/food/food_repo_impl.dart' as _i6;
import 'data/place/place_local_datasource.dart' as _i10;
import 'data/place/place_remote_datasource.dart' as _i11;
import 'data/place/place_repo_impl.dart' as _i13;
import 'domain/interactor/config/get_all_config_interactor.dart' as _i8;
import 'domain/interactor/food/add_food_interactor.dart' as _i15;
import 'domain/interactor/food/delete_food_interactor.dart' as _i17;
import 'domain/interactor/food/get_all_food_interactor.dart' as _i7;
import 'domain/interactor/food/observe_all_food_interactor.dart' as _i9;
import 'domain/interactor/place/add_place_interactor.dart' as _i16;
import 'domain/interactor/place/delete_place_interactor.dart' as _i18;
import 'domain/interactor/place/get_places_interactor.dart' as _i20;
import 'domain/interactor/place/observe_place_interactor.dart' as _i22;
import 'domain/repo/config_repo.dart' as _i3;
import 'domain/repo/food_repo.dart' as _i5;
import 'domain/repo/place_repo.dart' as _i12;
import 'presentation/page/food/food_manage_cubit.dart' as _i19;
import 'presentation/page/home/home_cubit.dart' as _i21;
import 'presentation/page/place/place_cubit.dart' as _i24;
import 'presentation/page/place_add/place_add_cubit.dart' as _i23;
import 'tuAI/tu_ai.dart' as _i14; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i10.PlaceLocalDataSource>(_i10.PlaceLocalDataSourceImpl());
  gh.factory<_i11.PlaceRemoteDataSource>(
      () => _i11.PlaceRemoteDataSourceImpl());
  gh.singleton<_i12.PlaceRepo>(_i13.PlaceRepoImpl(
      get<_i10.PlaceLocalDataSource>(), get<_i11.PlaceRemoteDataSource>()));
  gh.singleton<_i14.TuAi>(_i14.TuAiImpl());
  gh.factory<_i15.AddFoodInteractor>(
      () => _i15.AddFoodInteractor(get<_i5.FoodRepo>()));
  gh.factory<_i16.AddPlaceInteractor>(
      () => _i16.AddPlaceInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i17.DeleteFoodInteractor>(
      () => _i17.DeleteFoodInteractor(get<_i5.FoodRepo>()));
  gh.factory<_i18.DeletePlaceInteractor>(
      () => _i18.DeletePlaceInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i19.FoodManageCubit>(() => _i19.FoodManageCubit(
      get<_i9.ObserveAllFoodInteractor>(),
      get<_i15.AddFoodInteractor>(),
      get<_i17.DeleteFoodInteractor>()));
  gh.factory<_i20.GetPlacesInteractor>(
      () => _i20.GetPlacesInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i21.HomeCubit>(() => _i21.HomeCubit(
      get<_i9.ObserveAllFoodInteractor>(),
      get<_i14.TuAi>(),
      get<_i8.GetConfigInteractor>()));
  gh.factory<_i22.ObservePlaceInteractor>(
      () => _i22.ObservePlaceInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i23.PlaceAddCubit>(() => _i23.PlaceAddCubit(
      get<_i16.AddPlaceInteractor>(), get<_i9.ObserveAllFoodInteractor>()));
  gh.factory<_i24.PlaceCubit>(() => _i24.PlaceCubit(
      get<_i22.ObservePlaceInteractor>(),
      get<_i20.GetPlacesInteractor>(),
      get<_i18.DeletePlaceInteractor>()));
  return get;
}
