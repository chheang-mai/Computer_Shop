import 'package:computer_shop/bloc/bottom_nav_bloc.dart';
import 'package:computer_shop/bloc/cart_bloc.dart';
import 'package:computer_shop/bloc/counter_bloc.dart';
import 'package:computer_shop/model/product.dart';
import 'package:computer_shop/view/auth/signup_screen.dart';
import 'package:computer_shop/view/auth/slash_screen.dart';
import 'package:computer_shop/view/bottom_navbar.dart';
import 'package:computer_shop/view/detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavBloc()),
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        home: SlashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
