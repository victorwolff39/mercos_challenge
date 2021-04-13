import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/auth_data.dart';
import 'package:mercos_challenge/services/authentication.dart';
import 'package:mercos_challenge/ui/wisgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    String error;
    setState(() {
      _isLoading = true;
    });

    if (authData.isLogin) {
      error = await Authentication().signIn(authData);
    } else {
      error = await Authentication().signUp(authData);
    }

    if(error != null) {
      Fluttertoast.showToast(msg: error);
    } else {
      Fluttertoast.showToast(msg: "Logado com sucesso!");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // body: AuthForm(_handleSubmit),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  AuthForm(_handleSubmit),
                  if (_isLoading)
                    Positioned.fill(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
