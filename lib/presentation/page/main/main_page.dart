import 'package:de1_mobile_friends/presentation/page/common/app_bar.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_page.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_page.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_page.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomAppBar(
              onAppBarItemTap: (int index) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
            ),
            _content(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          FoodManagePage(),
          PlacePage(),
        ],
      ),
    );
  }
}
