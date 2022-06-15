import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/place_detail/place_detail_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/place_detail/place_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage({Key? key, this.placeId = ""}) : super(key: key);

  final String placeId;

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  PlaceDetailCubit? _cubit;
  TextEditingController? _reviewTextCtrl;

  @override
  void initState() {
    _cubit = getIt<PlaceDetailCubit>();
    _reviewTextCtrl ??= TextEditingController()
      ..addListener(() {
        _cubit?.onReviewTextChanged(_reviewTextCtrl?.text);
      });
    super.initState();
  }

  @override
  void dispose() {
    _cubit?.manualDispose();
    _reviewTextCtrl?.dispose();
    _cubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PlaceDetailCubit>(
        create: (context) => _cubit!..initialize(widget.placeId),
        child: BlocBuilder<PlaceDetailCubit, PlaceDetailState>(
          builder: (context, state) {
            if (state is PlaceDetailPrimaryState && state.place != null) {
              return Column(
                children: [
                  _placeInfo(state.place!),
                  const SizedBox(height: 16),
                  _reviewSection(state.place!),
                ],
              );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }

  Widget _reviewSection(Place place) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reviews'),
          const SizedBox(height: 16),
          _reviewInput(),
          const SizedBox(height: 32),
          _reviews(place.reviews),
        ],
      ),
    );
  }

  Widget _placeInfo(Place place) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Text(place.name),
    );
  }

  Widget _reviewInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _reviewTextCtrl!,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Write your review..',
                  ),
                ),
              ),
              Expanded(
                child: _reviewOptions(),
              )
            ],
          ),
          const SizedBox(width: 16),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 46,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16).copyWith(bottom: 0),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton(
              onPressed: () {
                _cubit?.submitReview();
                _reviewTextCtrl?.text = '';
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _reviews(Map<String, Review> reviews) {
    if (reviews.isEmpty) return const SizedBox.shrink();
    final List<Review> reviewList = [for (var e in reviews.entries) e.value]
      ..sort((a, b) =>
          b.createTimeMillisSinceEpoch.compareTo(a.createTimeMillisSinceEpoch));
    return SizedBox(
      height: 400,
      child: ListView.separated(
        separatorBuilder: (context, i) => const SizedBox(height: 8),
        itemCount: reviewList.length,
        itemBuilder: (context, i) {
          final item = reviewList[i];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                _rating(item.rating),
                Text(item.text),
                Text(item.price?.name ?? ''),
                Text(item.distance?.name ?? ''),
                Text(item.waitTime?.name ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _rating(int? rating) {
    final ratingCount = rating ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 5; i++)
          ratingCount <= i
              ? const Icon(Icons.star)
              : const Icon(
                  Icons.star_outlined,
                  color: Colors.amber,
                )
      ],
    );
  }

  Widget _reviewOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Overall rating'),
        _Rating(
          onRatingUpdate: _cubit!.onRatingUpdate,
        ),
        const Text('Price'),
        _PricePicker(
          onSelected: _cubit!.onPriceSelected,
        ),
        const Text('Distance'),
        _DistancePicker(
          onSelected: _cubit!.onDistanceSelected,
        ),
        const Text('Wait time'),
        _WaitTimePicker(
          onSelected: _cubit!.onWaitTimeSelected,
        ),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    Key? key,
    required this.label,
    required this.onSelected,
    required this.isSelected,
  }) : super(key: key);

  final String label;
  final Function(bool) onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selectedColor: Colors.blue,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}

class _PricePicker extends StatefulWidget {
  const _PricePicker({Key? key, required this.onSelected}) : super(key: key);

  final Function(RvPrice? price) onSelected;

  @override
  State<_PricePicker> createState() => __PricePickerState();
}

class __PricePickerState extends State<_PricePicker> {
  final List<RvPrice> _rvPrices = RvPrice.values;
  RvPrice? _selectedPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          itemCount: _rvPrices.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final item = _rvPrices[i];
            return _ChoiceChip(
              label: item.name,
              onSelected: (newBoolValue) {
                setState(() {
                  if (_selectedPrice?.name == item.name) {
                    _selectedPrice = null;
                  } else {
                    _selectedPrice = item;
                  }
                  widget.onSelected(_selectedPrice);
                });
              },
              isSelected: item.name == _selectedPrice?.name,
            );
          }),
    );
  }
}

class _DistancePicker extends StatefulWidget {
  const _DistancePicker({Key? key, required this.onSelected}) : super(key: key);

  final Function(RvDistance? distance) onSelected;

  @override
  State<_DistancePicker> createState() => __DistancePickerState();
}

class __DistancePickerState extends State<_DistancePicker> {
  final List<RvDistance> _rvDistances = RvDistance.values;
  RvDistance? _selectedDistance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          itemCount: _rvDistances.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final item = _rvDistances[i];
            return _ChoiceChip(
              label: item.name,
              onSelected: (newBoolValue) {
                setState(() {
                  if (_selectedDistance?.name == item.name) {
                    _selectedDistance = null;
                  } else {
                    _selectedDistance = item;
                  }
                  widget.onSelected(_selectedDistance);
                });
              },
              isSelected: item.name == _selectedDistance?.name,
            );
          }),
    );
  }
}

class _WaitTimePicker extends StatefulWidget {
  const _WaitTimePicker({Key? key, required this.onSelected}) : super(key: key);

  final Function(RvWaitTime? waitTime) onSelected;

  @override
  State<_WaitTimePicker> createState() => __WaitTimePickerState();
}

class __WaitTimePickerState extends State<_WaitTimePicker> {
  final List<RvWaitTime> _rvWaitTime = RvWaitTime.values;
  RvWaitTime? _selectedWaitTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          itemCount: _rvWaitTime.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final item = _rvWaitTime[i];
            return _ChoiceChip(
              label: item.name,
              onSelected: (newBoolValue) {
                setState(() {
                  if (_selectedWaitTime?.name == item.name) {
                    _selectedWaitTime = null;
                  } else {
                    _selectedWaitTime = item;
                  }
                  widget.onSelected(_selectedWaitTime);
                });
              },
              isSelected: item.name == _selectedWaitTime?.name,
            );
          }),
    );
  }
}

class _Rating extends StatelessWidget {
  final Function(double rating) onRatingUpdate;

  const _Rating({Key? key, required this.onRatingUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      glow: false,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
