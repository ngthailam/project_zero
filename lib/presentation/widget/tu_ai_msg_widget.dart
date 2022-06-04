import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:de1_mobile_friends/tuAI/tu_ai.dart';
import 'package:flutter/material.dart';

class TuAiMessageWidget extends StatelessWidget {
  const TuAiMessageWidget({
    Key? key,
    required this.tuAiOutput,
    required this.onYesNoRespond,
  }) : super(key: key);

  final TuAiOutput tuAiOutput;
  final Function(bool answer) onYesNoRespond;

  @override
  Widget build(BuildContext context) {
    switch (tuAiOutput.mode) {
      case TuAiOutputMode.plain_text:
        return _basicMsg(tuAiOutput.text);
      case TuAiOutputMode.suggest_type_yes_no:
        return _yesNoMsg();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _yesNoMsg() {
    return Column(
      children: [
        _basicMsg(tuAiOutput.text),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                onYesNoRespond(false);
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                onYesNoRespond(true);
              },
              child: Text("Yes"),
            ),
          ],
        )
      ],
    );
  }

  Widget _basicMsg(String msg) {
    return BubbleSpecialOne(
      text: msg,
      color: Colors.grey,
      tail: false,
      isSender: false,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
