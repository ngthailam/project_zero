import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_cubit.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_state.dart';
import 'package:de1_mobile_friends/presentation/page/food/widgets/food_type_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodManagePage extends StatefulWidget {
  const FoodManagePage({Key? key}) : super(key: key);

  @override
  State<FoodManagePage> createState() => _FoodManagePageState();
}

class _FoodManagePageState extends State<FoodManagePage> {
  FoodManageCubit? _cubit;

  TextEditingController? _createTextEdtCtrl;
  FocusNode? _createTextFocusNode;

  @override
  void initState() {
    _cubit = getIt<FoodManageCubit>();
    _createTextEdtCtrl = TextEditingController();
    _createTextFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _cubit?.disposeManual();
    _createTextEdtCtrl?.dispose();
    _createTextFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<FoodManageCubit>(
        create: (context) => _cubit!..initialize(),
        child: Row(
          children: [
            Expanded(child: _foodList()),
            Expanded(child: _addFood()),
          ],
        ),
      ),
    );
  }

  Widget _foodList() {
    return BlocConsumer<FoodManageCubit, FoodManageState>(
      listener: (context, state) {
        if (state is FoodManageErrorState && state.foods?.isNotEmpty != true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error ${state.e}")));
        }
      },
      builder: (context, state) {
        if (state is FoodManageInitialState) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state.foods?.isNotEmpty == true) {
          final list = state.foods!;
          return ListView.builder(
            itemBuilder: (context, i) {
              final double topMargin = i == 0 ? 18 : 4;
              return Container(
                margin: EdgeInsets.only(
                  top: topMargin,
                  left: 32,
                  right: 32,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1.0,
                    )),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(child: Text(list[i].name)),
                    IconButton(
                        onPressed: () {
                          _cubit?.deleteFood(list[i].id);
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 24,
                          color: Colors.grey,
                        ))
                  ],
                ),
              );
            },
            itemCount: list.length,
          );
        }

        if (state.foods?.isEmpty == true) {
          return Center(
            child: Text("No food yet"),
          );
        }

        return Center(
          child: Text("Something went wrong"),
        );
      },
    );
  }

  Widget _addFood() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create new food"),
            const SizedBox(height: 16),
            _nameInput(),
            const SizedBox(height: 16),
            Text("Choose food type"),
            const SizedBox(height: 8),
            _foodTypes(),
            const SizedBox(height: 16),
            _confirmBtn(),
          ],
        ),
      ),
    );
  }

  Widget _foodTypes() {
    return FoodTypePicker(
      onChangedType: (type) => _cubit?.onChangedType(type),
    );
  }

  Widget _confirmBtn() {
    return Container(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
          backgroundColor: MaterialStateProperty.all(Colors.blue[500]),
        ),
        onPressed: () {
          _cubit?.addFood(_createTextEdtCtrl?.text);
          _createTextEdtCtrl?.text = '';
        },
        child: Text(
          "Create",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _nameInput() {
    return Container(
      width: double.infinity,
      child: TextField(
        focusNode: _createTextFocusNode,
        onSubmitted: (text) {
          if (_createTextEdtCtrl?.text.isNotEmpty != true) {
            return;
          }
          _cubit?.addFood(text.trim());
          _createTextEdtCtrl?.text = '';
          _createTextFocusNode?.requestFocus();
        },
        controller: _createTextEdtCtrl,
        decoration: InputDecoration(hintText: "Food name"),
      ),
    );
  }
}
