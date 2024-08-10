import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/Screen/SplashScreen/SplashScreen.dart';
import 'package:shopping_cart/Service/CartBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: const MaterialApp(
        home: Splashscreen(),
      ),
    );
  }
}
