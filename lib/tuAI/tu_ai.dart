import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:injectable/injectable.dart';

class TuAiInput {
  final double? temp;

  TuAiInput({this.temp});
}

class TuAiUserInput {
  final String? text;

  TuAiUserInput(this.text);
}

enum TuAiOutputMode {
  plain_text,
  suggest_type_yes_no,
  filter_food,
}

class TuAiOutput {
  final String text;
  final FoodType? foodType;
  final TuAiOutputMode mode;

  TuAiOutput({
    required this.text,
    this.foodType,
    required this.mode,
  });
}

abstract class TuAi {
  TuAiOutput suggestFoodType(TuAiInput input);

  TuAiOutput respondsUserInput(TuAiUserInput input);
}

const positiveKeywords = [
  "ok",
  "yes",
  "được",
  "ổn",
  "hợp lý",
  "hợp ný",
  "duoc",
  "on"
];

const negativeKeywords = ["no", "nồ", "không", "đéo", "deo", "hok", "khong"];

const askKeywords = ["ăn", "eat", "an", "nên", "nen"];

@Singleton(as: TuAi)
class TuAiImpl extends TuAi {
  TuAiOutput? _prevOutput;

  @override
  TuAiOutput suggestFoodType(TuAiInput input) {
    var text = _prevOutput == null
        ? "Chào mấy Fen, tôi là Tú AI"
        : "Fen ơi, fen đang nói cái gì vậy";
    var suggestedFoodType = FoodType.allTrue();
    var mode = TuAiOutputMode.plain_text;

    if (input.temp != null && input.temp! > 26) {
      text =
          "Ngoài trời ${input.temp} độ, hay là ăn cái gì không NÓNG có được không ạ?";
      suggestedFoodType = suggestedFoodType.copyWith(
        hot: false,
      );
      mode = TuAiOutputMode.suggest_type_yes_no;
    }

    if (input.temp == null) {
      text = "Thôi quay bánh xe đi fen! Còn đợi gì nữa.";
    }

    _prevOutput = TuAiOutput(
      text: text,
      foodType: suggestedFoodType,
      mode: mode,
    );

    return _prevOutput!;
  }

  @override
  TuAiOutput respondsUserInput(TuAiUserInput input) {
    final cleanedUserInput = input.text?.toLowerCase() ?? '';
    var text = "Fen ơi, fen đang nói cái gì vậy";
    FoodType? suggestedFoodType = FoodType.allTrue();
    var mode = TuAiOutputMode.plain_text;

    if (_prevOutput?.mode != TuAiOutputMode.suggest_type_yes_no) {
      final isAskingSuggestion = askKeywords
          .any((element) => cleanedUserInput.contains(element.toLowerCase()));
      if (isAskingSuggestion) {
        return suggestFoodType(TuAiInput());
      }
    }

    if (_prevOutput?.mode == TuAiOutputMode.suggest_type_yes_no) {
      final isPositive = positiveKeywords
          .any((element) => cleanedUserInput.contains(element.toLowerCase()));
      final isNegative = negativeKeywords
          .any((element) => cleanedUserInput.contains(element.toLowerCase()));

      if (isPositive || isNegative) {
        suggestedFoodType = isPositive ? _prevOutput!.foodType! : null;
        mode = TuAiOutputMode.filter_food;
        text = isPositive
            ? "Hiphop never die, nghe tôi never sai"
            : "Ái chà, ok, rồi để xem tí thế nào";
      } else {
        text =
            "Fen ơi, fen đang nói cái gì vậy? Không chọn à, thôi mất lượt nhé";
      }
    }

    _prevOutput = TuAiOutput(
      text: text,
      foodType: suggestedFoodType,
      mode: mode,
    );

    return _prevOutput!;
  }
}
