import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/presentation/widget/slide_up_widget.dart';
import 'package:flutter/material.dart';

class OccassionChooser extends StatefulWidget {
  const OccassionChooser({
    Key? key,
    required this.onOccasionChosen,
    required this.occasion,
  }) : super(key: key);

  final Function(String occasionKey) onOccasionChosen;
  final Occasion occasion;

  @override
  State<OccassionChooser> createState() => _OccassionChooserState();
}

class _OccassionChooserState extends State<OccassionChooser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SlideUp(child: Text('Welcome to Happy Meal!')),
        const SizedBox(height: 16),
        const SlideUp(
            delay: Duration(milliseconds: 120),
            child: Text('What\'s the occasion ?')),
        const SizedBox(height: 24),
        SlideUp(
            delay: const Duration(milliseconds: 240),
            slideDuration: const Duration(seconds: 1),
            beginOffset: 0.4,
            child: _occasionPicker()),
      ],
    );
  }

  Widget _occasionPicker() {
    final occasionList = widget.occasion.occasions.entries
        .map((e) => _OccasionItem(
              onPressed: (String key) {
                // Do smt here
              },
              occasionEntry: e,
            ))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: occasionList,
    );
  }
}

class _OccasionItem extends StatefulWidget {
  const _OccasionItem({
    Key? key,
    required this.onPressed,
    required this.occasionEntry,
  }) : super(key: key);

  final Function(String key) onPressed;
  final MapEntry<String, String> occasionEntry;

  @override
  State<_OccasionItem> createState() => _OccasionItemState();
}

class _OccasionItemState extends State<_OccasionItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (isHovering) {
        if (_isHovering == isHovering) return;

        setState(() {
          _isHovering = !_isHovering;
        });
      },
      onTap: () {
        widget.onPressed.call(widget.occasionEntry.key);
      },
      child: Material(
        elevation: _isHovering ? 16 : 0,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              _content(),
              Positioned(top: 0, right: 0, left: 0, child: _mainImg()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainImg() {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        color: Colors.grey,
      ),
    );
  }

  Widget _content() {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: 160,
      height: 160,
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Center(child: Text(widget.occasionEntry.value)),
      ),
    );
  }
}
