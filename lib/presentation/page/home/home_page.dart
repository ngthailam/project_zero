import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/home/bloc/home_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/home/bloc/home_state.dart';
import 'package:de1_mobile_friends/presentation/page/home/widget/home/home_page_medium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomeCubit? _cubit;

  @override
  void initState() {
    _cubit = getIt<HomeCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _cubit?.manualDispose();
    _cubit = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider<HomeCubit>(
        create: (context) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _cubit?.initialize();
          });
          return _cubit!;
        },
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) async {
            // Do something here
          },
          child: const HomePageMedium(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
