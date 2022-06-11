import 'package:de1_mobile_friends/presentation/page/food/food_manage_page.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_page.dart';
import 'package:de1_mobile_friends/presentation/page/place/place_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<Tab> tabs = <Tab>[
    const Tab(text: 'Home', icon: Icon(Icons.home)),
    const Tab(text: 'Food', icon: Icon(Icons.food_bank)),
    const Tab(text: 'Place', icon: Icon(Icons.place)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController ??= TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _tabController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue,
            tabs: tabs,
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                HomePage(),
                FoodManagePage(),
                PlacePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
