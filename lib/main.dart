import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_connect/presentation/auth/login_page.dart';
import 'package:ride_connect/presentation/splash_screen.dart';

import 'application/auth/authentication_cubit.dart';
import 'firebase_options.dart';
import 'ioc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ✅ Initialize your service locators
  IoC();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
    BlocProvider.value(
    value: getIt<AuthenticationCubit>(),
    ),

    ],

   child:    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ride Connect',
      home: const SplashScreen(),
    ));
  }
}




