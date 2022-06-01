import 'dart:async';
import 'dart:math';

import 'package:de1_mobile_friends/domain/interactor/food/add_food_interactor.dart';
import 'package:de1_mobile_friends/domain/interactor/food/get_all_food_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Food> _foods = [];
  Food? _resultFood;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(height: 500, width: 500, child: _foodWheel()),
            _result(),
          ],
        ),
      ),
    );
  }

  StreamController<int> controller = StreamController<int>();

  Widget _result() {
    return Text(_resultFood?.name ?? '');
  }

  Widget _foodWheel() {
    return FutureBuilder(
      initialData: [],
      future: getIt<GetAllFoodInteractor>().execute(null),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        _foods = snapshot.data;

        if (_foods.length < 2) {
          return Center(child: CupertinoActivityIndicator());
        }

        return FortuneWheel(
          selected: controller.stream,
          duration: Duration(seconds: 5),
          onFling: () {
            Random random = Random();
            int randomNumber = random.nextInt(_foods.length);
            _resultFood = _foods[randomNumber];
            controller.add(randomNumber);
          },
          alignment: Alignment.centerRight,
          indicators: const [
            FortuneIndicator(
              alignment: Alignment.centerRight,
              child: TriangleIndicator(
                color: Colors.red,
              ),
            ),
          ],
          animateFirst: false,
          physics: CircularPanPhysics(
            duration: const Duration(seconds: 1),
            curve: Curves.decelerate,
          ),
          onAnimationEnd: () {
            // hien thong bao
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Selected=${_resultFood?.name ?? ''}")));
            });
          },
          items: _foods.map((e) => FortuneItem(child: Text(e.name))).toList(),
        );
      },
    );
  }
}
