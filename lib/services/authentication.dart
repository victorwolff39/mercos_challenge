import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mercos_challenge/models/auth_data.dart';

class Authentication {

  final _auth = FirebaseAuth.instance;

  //TODO: implement better Firebase error handling

   Future<String> signIn(AuthData authData) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: authData.email.trim(),
        password: authData.password,
      );
    } on PlatformException catch (err) {
      return err.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
    } catch (err) {
      return "Um erro inesperado ocorreu.";
    }
    return null;
  }

  Future<String> signUp(AuthData authData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: authData.email.trim(),
        password: authData.password,
      );
    } on PlatformException catch (err) {
      return err.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
    } catch (err) {
      return "Um erro inesperado ocorreu.";
    }
    return null;
  }
}