import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../lib/services/authentication.dart';
import '../../lib/models/auth_data.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockUserCredential extends Mock implements UserCredential{}
mixin MockFirebaseAuthException implements Mock, FirebaseAuthException {}

void main() {
  MockFirebaseAuth _auth = MockFirebaseAuth();

  group("Authentication", (){
    group("signInWithEmailAndPassword", (){
      Future<String> execute() async {
        AuthData authData = AuthData();
        authData.email = "email";
        authData.password = "password";
        Authentication authentication = Authentication(_auth);

        return await authentication.signIn(authData);
      }

      test("Success sign in with email and password", () async {
        //Arrange
        when(_auth.signInWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          return null;
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, null);
      });

      test("Invalid e-mail in sign in with email and password", () async {
        //Arrange
        when(_auth.signInWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "invalid-email");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "E-mail inválido.");
      });

      test("User disabled in sign in with email and password", () async {
        //Arrange
        when(_auth.signInWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "user-disabled");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "Usuário desativado.");
      });

      test("User not found in sign in with email and password", () async {
        //Arrange
        when(_auth.signInWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "user-not-found");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "Usuário não encontrado.");
      });

      test("Wrong password in sign in with email and password", () async {
        //Arrange
        when(_auth.signInWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "wrong-password");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "Senha incorreta.");
      });

      test("Unhandled exception in sign in with email and password", () async {
        //Arrange
        when(_auth.signInWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "random-message");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "Um erro desconhecido ocorreu.");
      });
    });

    group("createUserWithEmailAndPassword", (){
      Future<String> execute() async {
        AuthData authData = AuthData();
        authData.email = "email";
        authData.password = "password";
        Authentication authentication = Authentication(_auth);

        return await authentication.signUp(authData);
      }

      test("Success sign up with email and password", () async {
        //Arrange
        when(_auth.createUserWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          return null;
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, null);
      });

      test("E-mail already in use in sign up with email and password", () async {
        //Arrange
        when(_auth.createUserWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "email-already-in-use");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "O e-mail já está em uso.");
      });

      test("Invalid e-mail in use in sign up with email and password", () async {
        //Arrange
        when(_auth.createUserWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "invalid-email");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "E-mail inválido.");
      });

      test("Weak password in sign up with email and password", () async {
        //Arrange
        when(_auth.createUserWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "weak-password");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "Senha muito fraca.");
      });

      test("Unknown error in sign up with email and password", () async {
        //Arrange
        when(_auth.createUserWithEmailAndPassword(email: "email", password: "password")).thenAnswer((realInvocation) async {
          throw FirebaseAuthException(code: "random-message");
        });

        //Act
        String response = await execute();

        //Assert
        expect(response, "Um erro desconhecido ocorreu.");
      });
    });
  });
}
