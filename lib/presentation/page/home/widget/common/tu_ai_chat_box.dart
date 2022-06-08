import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/presentation/widget/tu_ai_widget.dart';
import 'package:flutter/widgets.dart';

class TuAiChatBox extends StatelessWidget {
  const TuAiChatBox({Key? key, required this.onRequestFilterByFoodType})
      : super(key: key);

  final Function(FoodType type) onRequestFilterByFoodType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Chat with AI:",
          style: TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: TuAiWidget(
            onRequestFilterByFoodType: (type) =>
                onRequestFilterByFoodType(type),
          ),
        ),
      ],
    );
  }
}
