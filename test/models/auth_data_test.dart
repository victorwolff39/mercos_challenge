import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/auth_data.dart';

main(){
  group("AuthData" , () {
    group("toggleMode", () {
      test("AuthMode.isSignUp should return true", (){
        //Arrange
        AuthData authData = AuthData();

        //Act
        authData.toggleMode();

        //Assert
        expect(authData.isSignUp, true);
      });

      test("AuthMode.isSignUp should return false", (){
        //Arrange
        AuthData authData = AuthData();

        //Act

        //Assert
        expect(authData.isSignUp, false);
      });
    });
  });
}