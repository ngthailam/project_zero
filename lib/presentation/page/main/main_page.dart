import 'package:de1_mobile_friends/presentation/page/common/app_bar.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_page.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_page.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_page.dart';
import 'package:de1_mobile_friends/presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            onAppBarItemTap: (int index) {
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
            },
          ),
          const Divider(
            color: colorFa6d85,
            indent: 128,
            endIndent: 128,
            thickness: 0.5,
          ),
          _content(),
        ],
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img/img_food.jpeg',
              color: Colors.white.withOpacity(0.1),
              colorBlendMode: BlendMode.modulate,
              repeat: ImageRepeat.repeat,
            ),
          ),
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomePage(),
                FoodManagePage(),
                PlacePage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
