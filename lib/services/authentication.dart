import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_data.dart';

class Authentication {
  final FirebaseAuth _auth;

  Authentication(this._auth);

  Future<String> signIn(AuthData authData) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: authData.email.trim(),
        password: authData.password,
      );
    } on PlatformException catch (err) {
      return err.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "invalid-email": {
          return "E-mail inválido.";
        }
        break;
        case "user-disabled": {
          return "Usuário desativado.";
        }
        break;
        case "user-not-found": {
          return "Usuário não encontrado.";
        }
        break;
        case "wrong-password": {
          return "Senha incorreta.";
        }
        break;
        default: {
          return "Um erro desconhecido ocorreu.";
        }
      }
    }
    return null;
  }

  Future<String> signUp(AuthData authData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: authData.email.trim(),
        password: authData.password,
      );
    }  on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "email-already-in-use": {
          return "O e-mail já está em uso.";
        }
        break;
        case "invalid-email": {
          return "E-mail inválido.";
        }
        break;
        case "weak-password": {
          return "Senha muito fraca.";
        }
        default: {
          return "Um erro desconhecido ocorreu.";
        }
      }
    }
    return null;
  }

  void signOut() {
    _auth.signOut();
  }
}
