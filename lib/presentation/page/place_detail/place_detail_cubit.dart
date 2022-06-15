import 'dart:async';

import 'package:de1_mobile_friends/domain/interactor/place/get_one_place_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/place/observe_one_place_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/review/add_review_interactor.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/presentation/page/place_detail/place_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlaceDetailCubit extends Cubit<PlaceDetailState> {
  PlaceDetailCubit(this._observeOnePlaceInteractor, this._getOnePlaceInteractor,
      this._addReviewInteractor)
      : super(PlaceDetailLoadingState());

  final ObserveOnePlaceInteractor _observeOnePlaceInteractor;
  final GetOnePlaceInteractor _getOnePlaceInteractor;
  final AddReviewInteractor _addReviewInteractor;
  StreamSubscription? _placeStreamSub;

  String _placeId = '';

  Review _currentReview = Review(text: '', placeId: '');

  void initialize(String id) async {
    _placeId = id;
    _currentReview = _currentReview.copyWith(placeId: _placeId);
    final place = await _getOnePlaceInteractor.execute(_placeId);
    if (place == null) {
      emit(PlaceDetailErrorState(Exception('Place invalid')));
      return;
    }
    emit(PlaceDetailPrimaryState(place: place));

    _placeStreamSub =
        _observeOnePlaceInteractor.execute(_placeId).listen((place) {
      if (place == null) {
        emit(PlaceDetailErrorState(Exception('Place invalid')));
        return;
      }
      emit(PlaceDetailPrimaryState(place: place));
    });
  }

  void manualDispose() {
    _placeStreamSub?.cancel();
  }

  void submitReview() async {
    final review = _currentReview;
    _currentReview = _currentReview.copyWith(text: '');
    try {
      await _addReviewInteractor.execute(review);
    } on Exception catch (_) {
      // Handle error here
    }
    // No need to emit state here
  }

  void onReviewTextChanged(String? text) {
    _currentReview = _currentReview.copyWith(text: text ?? '');
  }

  onPriceSelected(RvPrice? price) {
    _currentReview = _currentReview.copyWith(price: price);
  }

  onDistanceSelected(RvDistance? distance) {
    _currentReview = _currentReview.copyWith(distance: distance);
  }

  onWaitTimeSelected(RvWaitTime? waitTime) {
    _currentReview = _currentReview.copyWith(waitTime: waitTime);
  }

  onRatingUpdate(double rating) {
    _currentReview = _currentReview.copyWith(rating: rating.toInt());
  }
}
