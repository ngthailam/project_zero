// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/config/config_repo_impl.dart' as _i4;
import 'data/food/food_local_datasource.dart' as _i5;
import 'data/food/food_remote_datasource.dart' as _i6;
import 'data/food/food_repo_impl.dart' as _i22;
import 'data/occasion/occasion_local_datasource.dart' as _i8;
import 'data/occasion/occasion_remote_datasource.dart' as _i9;
import 'data/occasion/occasion_repo_impl.dart' as _i11;
import 'data/place/place_local_datasource.dart' as _i12;
import 'data/place/place_remote_datasource.dart' as _i13;
import 'data/place/place_repo_impl.dart' as _i15;
import 'domain/interactor/config/get_all_config_interactor.dart' as _i7;
import 'domain/interactor/food/add_food_interactor.dart' as _i36;
import 'domain/interactor/food/add_place_in_food_interactor.dart' as _i37;
import 'domain/interactor/food/delete_food_interactor.dart' as _i38;
import 'domain/interactor/food/get_all_food_interactor.dart' as _i23;
import 'domain/interactor/food/get_food_categories_interactor.dart' as _i24;
import 'domain/interactor/food/observe_all_food_interactor.dart' as _i28;
import 'domain/interactor/food/search_food_interactor.dart' as _i34;
import 'domain/interactor/occasion/get_occasions_interactor.dart' as _i25;
import 'domain/interactor/place/add_food_in_place_interactor.dart' as _i17;
import 'domain/interactor/place/add_place_interactor.dart' as _i18;
import 'domain/interactor/place/delete_place_interactor.dart' as _i20;
import 'domain/interactor/place/get_one_place_interactor.dart' as _i26;
import 'domain/interactor/place/get_places_interactor.dart' as _i27;
import 'domain/interactor/place/observe_one_place_interactor.dart' as _i29;
import 'domain/interactor/place/observe_places_interactor.dart' as _i30;
import 'domain/interactor/place/place_foods_interactor.dart' as _i33;
import 'domain/interactor/place/search_place_interactor.dart' as _i16;
import 'domain/interactor/review/add_review_interactor.dart' as _i19;
import 'domain/repo/config_repo.dart' as _i3;
import 'domain/repo/food_repo.dart' as _i21;
import 'domain/repo/occasion_repo.dart' as _i10;
import 'domain/repo/place_repo.dart' as _i14;
import 'presentation/page/food/common/add_place_in_food_cubit.dart' as _i42;
import 'presentation/page/food/food_manage_cubit.dart' as _i39;
import 'presentation/page/home/bloc/home_cubit.dart' as _i40;
import 'presentation/page/place/common/add_food_in_place_cubit.dart' as _i35;
import 'presentation/page/place/place_cubit.dart' as _i41;
import 'presentation/page/place_add/place_add_cubit.dart' as _i31;
import 'presentation/page/place_detail/place_detail_cubit.dart'
    as _i32; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ConfigRepo>(() => _i4.ConfigRepoImpl());
  gh.singleton<_i5.FoodLocalDataSource>(_i5.FoodLocalDataSourceImpl());
  gh.factory<_i6.FoodRemoteDataSource>(() => _i6.FoodRemoteDataSourceImpl());
  gh.factory<_i7.GetConfigInteractor>(
      () => _i7.GetConfigInteractor(get<_i3.ConfigRepo>()));
  gh.factory<_i8.OccasionLocalDataSource>(
      () => _i8.OccasionLocalDataSourceImpl());
  gh.factory<_i9.OccasionRemoteDataSource>(
      () => _i9.OccasionRemoteDataSourceImpl());
  gh.factory<_i10.OccasionRepo>(() => _i11.OccasionRepoImpl(
      get<_i9.OccasionRemoteDataSource>(), get<_i8.OccasionLocalDataSource>()));
  gh.singleton<_i12.PlaceLocalDataSource>(
      _i12.PlaceLocalDataSourceImpl(get<_i5.FoodLocalDataSource>()));
  gh.factory<_i13.PlaceRemoteDataSource>(
      () => _i13.PlaceRemoteDataSourceImpl());
  gh.singleton<_i14.PlaceRepo>(_i15.PlaceRepoImpl(
      get<_i12.PlaceLocalDataSource>(),
      get<_i13.PlaceRemoteDataSource>(),
      get<_i5.FoodLocalDataSource>(),
      get<_i6.FoodRemoteDataSource>()));
  gh.factory<_i16.SearchPlaceInteractor>(
      () => _i16.SearchPlaceInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i17.AddFoodInPlaceInteractor>(
      () => _i17.AddFoodInPlaceInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i18.AddPlaceInteractor>(
      () => _i18.AddPlaceInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i19.AddReviewInteractor>(
      () => _i19.AddReviewInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i20.DeletePlaceInteractor>(
      () => _i20.DeletePlaceInteractor(get<_i14.PlaceRepo>()));
  gh.singleton<_i21.FoodRepo>(_i22.FoodRepoImpl(
      get<_i10.OccasionRepo>(),
      get<_i12.PlaceLocalDataSource>(),
      get<_i5.FoodLocalDataSource>(),
      get<_i13.PlaceRemoteDataSource>(),
      get<_i6.FoodRemoteDataSource>()));
  gh.factory<_i23.GetAllFoodInteractor>(
      () => _i23.GetAllFoodInteractor(get<_i21.FoodRepo>()));
  gh.factory<_i24.GetFoodCategoriesInteractor>(
      () => _i24.GetFoodCategoriesInteractor(get<_i21.FoodRepo>()));
  gh.factory<_i25.GetOccasionInteractor>(
      () => _i25.GetOccasionInteractor(get<_i10.OccasionRepo>()));
  gh.factory<_i26.GetOnePlaceInteractor>(
      () => _i26.GetOnePlaceInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i27.GetPlacesInteractor>(
      () => _i27.GetPlacesInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i28.ObserveAllFoodInteractor>(
      () => _i28.ObserveAllFoodInteractor(get<_i21.FoodRepo>()));
  gh.factory<_i29.ObserveOnePlaceInteractor>(
      () => _i29.ObserveOnePlaceInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i30.ObservePlacesInteractor>(
      () => _i30.ObservePlacesInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i31.PlaceAddCubit>(() => _i31.PlaceAddCubit(
      get<_i18.AddPlaceInteractor>(), get<_i28.ObserveAllFoodInteractor>()));
  gh.factory<_i32.PlaceDetailCubit>(() => _i32.PlaceDetailCubit(
      get<_i29.ObserveOnePlaceInteractor>(),
      get<_i26.GetOnePlaceInteractor>(),
      get<_i19.AddReviewInteractor>()));
  gh.factory<_i33.PlaceFoodsInteractor>(
      () => _i33.PlaceFoodsInteractor(get<_i14.PlaceRepo>()));
  gh.factory<_i34.SearchFoodInteractor>(
      () => _i34.SearchFoodInteractor(get<_i21.FoodRepo>()));
  gh.factory<_i35.AddFoodInPlaceCubit>(() => _i35.AddFoodInPlaceCubit(
      get<_i17.AddFoodInPlaceInteractor>(), get<_i34.SearchFoodInteractor>()));
  gh.factory<_i36.AddFoodInteractor>(
      () => _i36.AddFoodInteractor(get<_i21.FoodRepo>()));
  gh.factory<_i37.AddPlaceInFoodInteractor>(
      () => _i37.AddPlaceInFoodInteractor(get<_i21.FoodRepo>()));
  gh.factory<_i38.DeleteFoodInteractor>(
      () => _i38.DeleteFoodInteractor(get<_i21.FoodRepo>()));
  gh.factory<_i39.FoodManageCubit>(() => _i39.FoodManageCubit(
      get<_i28.ObserveAllFoodInteractor>(),
      get<_i36.AddFoodInteractor>(),
      get<_i38.DeleteFoodInteractor>(),
      get<_i25.GetOccasionInteractor>(),
      get<_i24.GetFoodCategoriesInteractor>()));
  gh.factory<_i40.HomeCubit>(() => _i40.HomeCubit(
      get<_i28.ObserveAllFoodInteractor>(), get<_i25.GetOccasionInteractor>()));
  gh.factory<_i41.PlaceCubit>(() => _i41.PlaceCubit(
      get<_i30.ObservePlacesInteractor>(),
      get<_i27.GetPlacesInteractor>(),
      get<_i20.DeletePlaceInteractor>(),
      get<_i33.PlaceFoodsInteractor>(),
      get<_i34.SearchFoodInteractor>()));
  gh.factory<_i42.AddPlaceInFoodCubit>(() => _i42.AddPlaceInFoodCubit(
      get<_i16.SearchPlaceInteractor>(), get<_i37.AddPlaceInFoodInteractor>()));
  return get;
}
