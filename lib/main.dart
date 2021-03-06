import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/clients_provider.dart';
import './providers/orders_provider.dart';
import './ui/screens/auth_screen.dart';
import './ui/screens/home_screen.dart';
import './ui/screens/product_selection_screen.dart';
import './utils/constants/app_routes.dart';
import './providers/products_provider.dart';
import './ui/screens/splash_screen.dart';

void main() async {
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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => new ProductsProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => new ClientsProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => new OrdersProvider(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // Desativar o banner de Debug
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
                return userSnapshot.hasData ? HomeScreen() : AuthScreen();
              },
            ),
            routes: {
              AppRoutes.SELECT_PRODUCT: (ctx) => ProductSelectionScreen(),
            },
          ),
        );
      },
    );
  }
}
