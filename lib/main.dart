import 'package:de1_mobile_friends/app_router.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
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
  getIt<PlaceRepo>().initialize();

  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Happy meal',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'OpenSans'),
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      initialRoute: AppRouter.main,
      // routes: {
      //   AppRouter.main: (context) => const MainPage(),
      //   AppRouter.home: (context) => const HomePage(),
      //   AppRouter.foodManage: (context) => const FoodManagePage(),
      //   AppRouter.placeDetail: (context) => PlaceDetailPage())
      // },
    );
  }
}
