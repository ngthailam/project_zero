import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:injectable/injectable.dart';

class TuAiInput {
  final double? temp;

  TuAiInput({this.temp});
}

enum TuAiOutputMode {
  plain_text,
  suggest_type_yes_no,
}

class TuAiOutput {
  final String text;
  final FoodType? suggestedFoodType;
  final TuAiOutputMode mode;

  TuAiOutput({
    required this.text,
    this.suggestedFoodType,
    required this.mode,
  });
}

abstract class TuAi {
  TuAiOutput suggestFoodType(TuAiInput input);
}

@Singleton(as: TuAi)
class TuAiImpl extends TuAi {
  @override
  TuAiOutput suggestFoodType(TuAiInput input) {
    var text = "English, mf! Do you speak it?!";
    var suggestedFoodType = FoodType.allTrue();
    var mode = TuAiOutputMode.plain_text;

    if (input.temp != null && input.temp! > 26) {
      text =
          "Its ${input.temp}\u1d52C, how about eating something thats not HOT?";
      suggestedFoodType = suggestedFoodType.copyWith(
        hot: false,
      );
      mode = TuAiOutputMode.suggest_type_yes_no;
    }

    return TuAiOutput(
      text: text,
      suggestedFoodType: suggestedFoodType,
      mode: mode,
    );
  }
}
