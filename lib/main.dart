import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brocker/Network/remote/dio.dart';
import 'package:brocker/Network/remote/webSocket.dart';
import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/appCubite/stats.dart';
import 'package:brocker/screens/loginScreen/cubit/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appCubite/myBlockObserver.dart';
import 'component/components.dart';
import 'screens/introScreen/introScreen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
           
        ),
        BlocProvider(
          create: (context) => LoginCubit()
           
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeData,
            home: IntroScreen(),
          );
        },
      ),
    );
  }
}
