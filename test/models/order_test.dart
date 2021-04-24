import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/product.dart';
import '../../lib/models/order.dart';

main() {
  group("Order", () {
    group("pctDifference", () {
      test(
          "Given a product price of 50,00 and a item price of 75,00, should return 50",
              () {
            //Arrange
            final OrderItem item = OrderItem(
              product: Product(
                id: 1,
                name: "Test product",
                imageUrl: "Url",
                price: 50,
              ),
              price: 75,
            );

            //Act
            double pct = item.pctDifference();

            //Assert
            expect(pct, 50);
          });

      test(
          "Given a product price of 100,00 and a item price of 50,00, should return -50",
          () {
        //Arrange
        final OrderItem item = OrderItem(
          product: Product(
            id: 1,
            name: "Test product",
            imageUrl: "Url",
            price: 100,
          ),
          price: 50,
        );

        //Act
        double pct = item.pctDifference();

        //Assert
        expect(pct, -50);
      });

      test(
          "Given a product price of 50,00 and a item price of 50,00, should return 0",
              () {
            //Arrange
            final OrderItem item = OrderItem(
              product: Product(
                id: 1,
                name: "Test product",
                imageUrl: "Url",
                price: 50,
              ),
              price: 50,
            );

            //Act
            double pct = item.pctDifference();

            //Assert
            expect(pct, 0);
          });
    });
  });
}
