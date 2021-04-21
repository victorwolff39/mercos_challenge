import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mercos_challenge/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  final Function(Order order) deleteOrder;

  OrderWidget({this.order, this.deleteOrder});

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  deleteOrder(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Deletar pedido?"),
        content: const Text(
          "Deseja apagar permanentemente este pedido?",
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Não"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Sim"),
          ),
        ],
      ),
    ).then((value) {
      if (value != null) {
        if (value) {
          widget.deleteOrder(widget.order);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemsHeight = (widget.order.items.length * 25.0) + 10;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? itemsHeight + 144 : 144,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.order.client.imageUrl),
              ),
              title: Text(widget.order.client.name),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy  hh:mm').format(widget.order.date)),
              trailing: IconButton(
                icon: Row(
                  children: [
                    Icon(!_expanded ? Icons.expand_more : Icons.expand_less),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              height: _expanded ? itemsHeight : 0,
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: ListView(
                children: widget.order.items.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${product.quantity} x ${product.product.formattedPrice()}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  //Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              size: 20,
                            ),
                            onPressed: () {
                              deleteOrder(context);
                            },
                          ),
                        ],
                      ),
                      Text(
                        "Total: ${widget.order.formattedTotal()}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
