import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/product.dart';

main() {
  group("Product", () {
    group("verifyMultiple", () {
      test("Given a multiple of 5 and quantity of 10, should return true", () {
        //Arrange
        final Product product = Product(
          id: 1,
          name: "Test Product",
          imageUrl: "Url",
          price: 125000,
          multiple: 5,
        );

        //Act
        bool verifyMultiple = product.verifyMultiple(10);

        //Assert
        expect(verifyMultiple, true);
      });

      test("Given a multiple of 5 and quantity of 7, should return false", () {
        //Arrange
        final Product product = Product(
          id: 1,
          name: "Test Product",
          imageUrl: "Url",
          price: 125000,
          multiple: 5,
        );

        //Act
        bool verifyMultiple = product.verifyMultiple(7);

        //Assert
        expect(verifyMultiple, false);
      });

      test("Given a null multiple and quantity of 7, should return true", () {
        //Arrange
        final Product product = Product(
          id: 1,
          name: "Test Product",
          imageUrl: "Url",
          price: 125000,
        );

        //Act
        bool verifyMultiple = product.verifyMultiple(7);

        //Assert
        expect(verifyMultiple, true);
      });
    });
  });
}
