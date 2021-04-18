import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/models/product.dart';
import 'package:mercos_challenge/ui/widgets/products/rentability_indicator.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;
  final Function(OrderItem) removeProduct;

  OrderItemWidget(this.orderItem, this.removeProduct);

  @override
  Widget build(BuildContext context) {
    Product product = orderItem.product;

    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                      placeholder: AssetImage('assets/images/placeholder.png'),
                      image: product.imageUrl != null
                          ? NetworkImage(product.imageUrl)
                          : AssetImage('assets/images/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                    ),
                    Text("Quantidade: ${orderItem.quantity}")
                  ],
                ),
                if (orderItem.rentability != 0) RentabilityIndicator(orderItem),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        "Preço unitário: ${orderItem.product.formattedPrice()}"),
                    SizedBox(height: 8),
                    Text("Total: ${orderItem.formattedPrice()}"),
                  ],
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => removeProduct(orderItem),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
