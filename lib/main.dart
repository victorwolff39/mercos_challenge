import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mercos_challenge/ui/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //Iniciar a instância do Firebase
      future: Firebase.initializeApp(),
      builder: (context, appSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Desafio Mercos",
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.pinkAccent,
            accentColorBrightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: appSnapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (!userSnapshot.hasData) {
                return Center(child: Text("Tela de login"));
                //return AuthScreen();
              } else {
                return SplashScreen();
                //return HomeScreen();
              }
            },
          ),
        );
      },
    );
  }
}
