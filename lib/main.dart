import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/logic/cubit/weather_cubit.dart';
import 'package:flutter_application_1/presentation/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubit/internet_cubit.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
      overlays: [SystemUiOverlay.bottom]);

  HttpOverrides.global = new PostHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  List<BlocProvider> blocProviders = [
    BlocProvider<InternetCubit>(
      create: (context) => InternetCubit(connectivity: Connectivity()),
    ),
    BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit(),
    ),
  ];

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext myAppContext) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Weather',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
