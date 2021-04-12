import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Carregando...",
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline1.color,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
