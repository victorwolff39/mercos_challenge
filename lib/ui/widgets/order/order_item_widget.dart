import 'package:flutter/material.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../widgets/products/rentability_indicator.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;
  final Function(OrderItem) removeProduct;
  final BoxConstraints constraints;

  OrderItemWidget({
    this.orderItem,
    this.removeProduct,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    Product product = orderItem.product;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth * 0.30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(product.id.toString()),
                      SizedBox(width: 10),
                      if (constraints.maxWidth > 900)
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          child: Container(
                            width: 80,
                            height: 50,
                            child: FadeInImage(
                              placeholder:
                              AssetImage('assets/images/placeholder.png'),
                              image: product.imageUrl != null
                                  ? NetworkImage(product.imageUrl)
                                  : AssetImage('assets/images/placeholder.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(width: 8),
                      if (constraints.maxWidth > 900)
                        Flexible(
                          child: Text(
                            product.name,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ),
                        ),
                      if (constraints.maxWidth <= 900) Flexible(child: Text(product.name)),
                    ],
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.20,
                  child: Row(
                    children: [
                      Flexible(child: Text(orderItem.product.formattedPrice())),
                      if (constraints.maxWidth > 900)
                        if (orderItem.rentability != 0)
                          RentabilityIndicator(orderItem),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: constraints.maxWidth * 0.07,
                  child: Text(orderItem.quantity.toString()),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: constraints.maxWidth * 0.20,
                  child: Text(orderItem.formattedPrice()),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              width: constraints.maxWidth * 0.05,
              child: IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => removeProduct(orderItem),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
