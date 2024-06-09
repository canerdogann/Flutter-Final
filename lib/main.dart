import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/bloc/cart/cart_cubit.dart';
import 'package:flutter_advanced_dev/bloc/client/client_cubit.dart';
import 'package:flutter_advanced_dev/bloc/products/products_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/localizations.dart';
import 'core/routes.dart';
import 'core/themes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  FirebaseOptions options = const FirebaseOptions(
    apiKey: "AIzaSyAWKzSjTaMpXztL2nEFg-BoR8GL0tdCwUQ",
    authDomain: "flutter-7133d.firebaseapp.com",
    projectId: "flutter-7133d",
    storageBucket: "flutter-7133d.appspot.com",
    messagingSenderId: "404125770805",
    appId: "1:404125770805:android:0c4efb5951c99ab9ecfd7c",
  );

  await Firebase.initializeApp(options: options);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ClientCubit(
                  ClientState(darkMode: false, language: "en"),
                )),
        BlocProvider(
            create: (context) => CartCubit(
                  CartState(sepet: []),
                )),
        BlocProvider(
            create: (context) => ProductsCubit(
                  ProductsState(favorites: []),
                )),
      ],
      child: BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
          ],
          locale: Locale(state.language),
        );
      }),
    );
  }
}
