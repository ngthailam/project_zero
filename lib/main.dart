import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/data/client/weather_client.dart';
import 'package:de1_mobile_friends/data/config_client/dio_client.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_page.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'main.config.dart';

// This is our global ServiceLocator
final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      databaseURL:
          'https://project-zero-384ad-default-rtdb.asia-southeast1.firebasedatabase.app/',
      apiKey: "AIzaSyDwBNR1MVoB6MF0-a6s_rwX8ASYoahWOOE",
      appId: "1:524295653021:web:30ac226a83309dc5f0b674",
      messagingSenderId: "524295653021",
      projectId: "project-zero-384ad",
    ),
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Siêu AI anh Tú',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRouter.home,
      routes: {
        AppRouter.home: (context) => const HomePage(),
        AppRouter.foodManage: (context) => const FoodManagePage(),
      },
    );
  }
}
