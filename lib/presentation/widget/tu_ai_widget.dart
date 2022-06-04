import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:de1_mobile_friends/domain/interactor/config/get_all_config_interactor.dart';
import 'package:de1_mobile_friends/domain/model/config.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/widget/tu_ai_msg_widget.dart';
import 'package:de1_mobile_friends/tuAI/tu_ai.dart';
import 'package:flutter/material.dart';

class TuAiWidget extends StatefulWidget {
  const TuAiWidget({Key? key}) : super(key: key);

  @override
  State<TuAiWidget> createState() => _TuAiWidgetState();
}

class _TuAiWidgetState extends State<TuAiWidget> {
  TextEditingController? _textEdtTrl;

  bool _isWaitingTuAi = true;

  List<Messages> _messages = [];

  TuAi _tuAi = getIt<TuAi>();

  Config _config = Config();

  final GetConfigInteractor _getConfigInteractor = getIt<GetConfigInteractor>();

  @override
  void initState() {
    super.initState();
    _initializeData();
    _textEdtTrl = TextEditingController();
  }

  void _initializeData() async {
    _config = await _getConfigInteractor.execute(null);
    final suggest = _tuAi.suggestFoodType(TuAiInput(temp: _config.temp));
    setState(() {
      _messages.add(
        Messages(isSender: false, tuAiOutput: suggest),
      );
      _isWaitingTuAi = false;
    });
  }

  @override
  void dispose() {
    _textEdtTrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            _tuAiMsg(3),
            const SizedBox(height: 16),
            _tuAiMsg(2),
            const SizedBox(height: 16),
            _tuAiMsg(1),
            const SizedBox(height: 16),
            _textInput(),
          ],
        ));
  }

  Widget _tuAiMsg(int position) {
    if (_messages.length < position) {
      return SizedBox.shrink();
    }
    final msg = _messages[_messages.length - position];
    if (msg.isSender) {
      return _myMsg(msg.myMsg);
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/img/tu_face_neutral.png'),
            ),
          ),
          Expanded(
            child: TuAiMessageWidget(
              tuAiOutput: msg.tuAiOutput!,
              onYesNoRespond: (bool ans) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Not supported yet')));
              },
            ),
          )
        ],
      );
    }
  }

  Widget _myMsg(String? msg) {
    return BubbleSpecialOne(
      text: msg ?? "",
      color: Color(0xFF1B97F3),
      tail: false,
      isSender: true,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  Widget _textInput() {
    return TextField(
      enabled: !_isWaitingTuAi,
      decoration: InputDecoration(
        hintText: 'Say something to Tú AI',
        suffixIcon: IconButton(
          icon: Icon(
            Icons.send,
            color: _isWaitingTuAi ? Colors.grey : Colors.blue,
          ),
          onPressed: () {
            if (_textEdtTrl?.text.isNotEmpty != true) {
              return;
            }
            final userMsg = _textEdtTrl?.text ?? '';
            setState(() {
              _messages.add(
                Messages(isSender: true, myMsg: userMsg),
              );
              _textEdtTrl?.text = '';
              _isWaitingTuAi = true;
              _triggerTuAi(userMsg);
            });
          },
        ),
      ),
      controller: _textEdtTrl,
    );
  }

  void _triggerTuAi(String userMsg) {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        final suggest = _tuAi.suggestFoodType(TuAiInput());
        _messages.add(
          Messages(isSender: false, tuAiOutput: suggest),
        );
        _isWaitingTuAi = false;
      });
    });
  }
}

class Messages {
  final bool isSender;
  final String? myMsg;
  final TuAiOutput? tuAiOutput;

  Messages({
    required this.isSender,
    this.myMsg,
    this.tuAiOutput,
  });
}
