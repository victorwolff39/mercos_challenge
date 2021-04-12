import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mercos_challenge/ui/screens/auth/auth_screen.dart';
import 'package:mercos_challenge/ui/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      /*
       * Iniciar a instância do Firebase
       */
      future: Firebase.initializeApp(),
      builder: (context, appSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Desativar o banner de Debug
          title: "Desafio Mercos",
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.pinkAccent,
            accentColorBrightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          /*
           * Verifica se a aplicação já conectou no Firebase. Caso ainda não
           * tenha se conectado, retorna a SpashScreen (tela de loading)
           */
          home: appSnapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : StreamBuilder(
            /*
             * Pega uma instância do usuário no Firebase e monitora caso o estado dela mude.
             */
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (!userSnapshot.hasData) {
                return AuthScreen();
              } else {
                //return SplashScreen();
                return Center(child: Text("Logado!!"));
              }
            },
          ),
        );
      },
    );
  }
}
