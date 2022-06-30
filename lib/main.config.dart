// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/config/config_repo_impl.dart' as _i4;
import 'data/food/food_repo_impl.dart' as _i19;
import 'data/occasion/occasion_local_datasource.dart' as _i6;
import 'data/occasion/occasion_remote_datasource.dart' as _i7;
import 'data/occasion/occasion_repo_impl.dart' as _i9;
import 'data/place/place_local_datasource.dart' as _i10;
import 'data/place/place_remote_datasource.dart' as _i11;
import 'data/place/place_repo_impl.dart' as _i13;
import 'domain/interactor/config/get_all_config_interactor.dart' as _i5;
import 'domain/interactor/food/add_food_interactor.dart' as _i31;
import 'domain/interactor/food/delete_food_interactor.dart' as _i32;
import 'domain/interactor/food/get_all_food_interactor.dart' as _i20;
import 'domain/interactor/food/observe_all_food_interactor.dart' as _i24;
import 'domain/interactor/food/search_food_interactor.dart' as _i30;
import 'domain/interactor/occasion/get_occasions_interactor.dart' as _i21;
import 'domain/interactor/place/add_place_interactor.dart' as _i15;
import 'domain/interactor/place/delete_place_interactor.dart' as _i17;
import 'domain/interactor/place/get_one_place_interactor.dart' as _i22;
import 'domain/interactor/place/get_places_interactor.dart' as _i23;
import 'domain/interactor/place/observe_one_place_interactor.dart' as _i25;
import 'domain/interactor/place/observe_places_interactor.dart' as _i26;
import 'domain/interactor/place/place_foods_interactor.dart' as _i29;
import 'domain/interactor/review/add_review_interactor.dart' as _i16;
import 'domain/repo/config_repo.dart' as _i3;
import 'domain/repo/food_repo.dart' as _i18;
import 'domain/repo/occasion_repo.dart' as _i8;
import 'domain/repo/place_repo.dart' as _i12;
import 'presentation/page/food/food_manage_cubit.dart' as _i33;
import 'presentation/page/home/home_cubit.dart' as _i34;
import 'presentation/page/place/place_cubit.dart' as _i35;
import 'presentation/page/place_add/place_add_cubit.dart' as _i27;
import 'presentation/page/place_detail/place_detail_cubit.dart' as _i28;
import 'tuAI/tu_ai.dart' as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ConfigRepo>(() => _i4.ConfigRepoImpl());
  gh.factory<_i5.GetConfigInteractor>(
      () => _i5.GetConfigInteractor(get<_i3.ConfigRepo>()));
  gh.factory<_i6.OccasionLocalDataSource>(
      () => _i6.OccasionLocalDataSourceImpl());
  gh.factory<_i7.OccasionRemoteDataSource>(
      () => _i7.OccasionRemoteDataSourceImpl());
  gh.factory<_i8.OccasionRepo>(() => _i9.OccasionRepoImpl(
      get<_i7.OccasionRemoteDataSource>(), get<_i6.OccasionLocalDataSource>()));
  gh.singleton<_i10.PlaceLocalDataSource>(_i10.PlaceLocalDataSourceImpl());
  gh.factory<_i11.PlaceRemoteDataSource>(
      () => _i11.PlaceRemoteDataSourceImpl());
  gh.singleton<_i12.PlaceRepo>(_i13.PlaceRepoImpl(
      get<_i10.PlaceLocalDataSource>(), get<_i11.PlaceRemoteDataSource>()));
  gh.singleton<_i14.TuAi>(_i14.TuAiImpl());
  gh.factory<_i15.AddPlaceInteractor>(
      () => _i15.AddPlaceInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i16.AddReviewInteractor>(
      () => _i16.AddReviewInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i17.DeletePlaceInteractor>(
      () => _i17.DeletePlaceInteractor(get<_i12.PlaceRepo>()));
  gh.singleton<_i18.FoodRepo>(_i19.FoodRepoImpl(get<_i8.OccasionRepo>()));
  gh.factory<_i20.GetAllFoodInteractor>(
      () => _i20.GetAllFoodInteractor(get<_i18.FoodRepo>()));
  gh.factory<_i21.GetOccasionInteractor>(
      () => _i21.GetOccasionInteractor(get<_i8.OccasionRepo>()));
  gh.factory<_i22.GetOnePlaceInteractor>(
      () => _i22.GetOnePlaceInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i23.GetPlacesInteractor>(
      () => _i23.GetPlacesInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i24.ObserveAllFoodInteractor>(
      () => _i24.ObserveAllFoodInteractor(get<_i18.FoodRepo>()));
  gh.factory<_i25.ObserveOnePlaceInteractor>(
      () => _i25.ObserveOnePlaceInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i26.ObservePlacesInteractor>(
      () => _i26.ObservePlacesInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i27.PlaceAddCubit>(() => _i27.PlaceAddCubit(
      get<_i15.AddPlaceInteractor>(), get<_i24.ObserveAllFoodInteractor>()));
  gh.factory<_i28.PlaceDetailCubit>(() => _i28.PlaceDetailCubit(
      get<_i25.ObserveOnePlaceInteractor>(),
      get<_i22.GetOnePlaceInteractor>(),
      get<_i16.AddReviewInteractor>()));
  gh.factory<_i29.PlaceFoodsInteractor>(
      () => _i29.PlaceFoodsInteractor(get<_i12.PlaceRepo>()));
  gh.factory<_i30.SearchFoodInteractor>(
      () => _i30.SearchFoodInteractor(get<_i18.FoodRepo>()));
  gh.factory<_i31.AddFoodInteractor>(
      () => _i31.AddFoodInteractor(get<_i18.FoodRepo>()));
  gh.factory<_i32.DeleteFoodInteractor>(
      () => _i32.DeleteFoodInteractor(get<_i18.FoodRepo>()));
  gh.factory<_i33.FoodManageCubit>(() => _i33.FoodManageCubit(
      get<_i24.ObserveAllFoodInteractor>(),
      get<_i31.AddFoodInteractor>(),
      get<_i32.DeleteFoodInteractor>(),
      get<_i21.GetOccasionInteractor>()));
  gh.factory<_i34.HomeCubit>(() => _i34.HomeCubit(
      get<_i24.ObserveAllFoodInteractor>(),
      get<_i14.TuAi>(),
      get<_i5.GetConfigInteractor>(),
      get<_i21.GetOccasionInteractor>()));
  gh.factory<_i35.PlaceCubit>(() => _i35.PlaceCubit(
      get<_i26.ObservePlacesInteractor>(),
      get<_i23.GetPlacesInteractor>(),
      get<_i17.DeletePlaceInteractor>(),
      get<_i29.PlaceFoodsInteractor>(),
      get<_i30.SearchFoodInteractor>()));
  return get;
}
