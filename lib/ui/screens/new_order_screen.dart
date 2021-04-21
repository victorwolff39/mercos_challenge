import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:mercos_challenge/providers/orders_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/ui/widgets/clients/clients_item.dart';
import 'package:mercos_challenge/ui/widgets/order/order_item_widget.dart';
import 'package:mercos_challenge/ui/widgets/order/select_client_button.dart';
import 'package:mercos_challenge/utils/constants/app_routes.dart';

class NewOrderScreen extends StatefulWidget {
  final Function selectOrderScreen;

  NewOrderScreen(this.selectOrderScreen);

  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  Client client;
  List<OrderItem> orderItems = [];
  Order order;
  double orderTotal = 0;

  void selectClient(Client selectedClient) {
    setState(() {
      client = selectedClient;
    });
  }

  Widget header(IconData icon, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 32, color: Theme.of(context).accentColor),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20),
        )
      ],
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(),
    );
  }

  void removeItem(OrderItem orderItem) {
    setState(() {
      orderItems.remove(orderItem);
      Fluttertoast.showToast(msg: "Item removido.");
    });
  }

  void addProduct() {
    /*
     * Abre a tela para adicionar um produto e adiciona ele na lista quando o usuário seleciona um produto.
     */
    Navigator.of(context).pushNamed(AppRoutes.SELECT_PRODUCT).then((value) {
      if (value != null) {
        OrderItem orderItem = value;
        bool isPresent = false;
        /*
         * Verifica se já existe o mesmo item no pedido.
         */
        orderItems.forEach((element) {
          if (element.product.id == orderItem.product.id) {
            Fluttertoast.showToast(msg: "Item já presente no pedido.");
            isPresent = true;
            return;
          }
        });
        if (!isPresent) {
          setState(() {
            orderItems.add(orderItem);
            totalItems();
          });
        }
      }
    });
  }

  void saveOrder() {
    if (client == null) {
      Fluttertoast.showToast(msg: "Nenhum cliente selecionado.");
    } else if (orderItems.length <= 0) {
      Fluttertoast.showToast(msg: "O pedido não contém nenhum item.");
    } else {
      order = Order(
        client: client,
        items: orderItems,
        total: totalItems(),
        date: DateTime.now(),
      );
      Provider.of<OrdersProvider>(context, listen: false).addOrder(this.order);
      //Navigator.of(context).pop();
      widget.selectOrderScreen();
    }
  }

  double totalItems() {
    orderTotal = 0;
    this.orderItems.forEach((element) {
      orderTotal = orderTotal + element.price;
    });
    return orderTotal;
  }

  String formattedTotal(double total) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatCurrency.format(total).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(Icons.business, "CLIENTE"),
              /*
               * Se houver um cliente selecionado, mostra, se não, pede para selecionar
               */
              client != null
                  ? ClientItem(client)
                  : SelectClientButton(selectClient, client),
              divider(),
              header(Icons.menu_book, "PRODUTOS"),
              Column(
                children: [
                  SizedBox(height: 20),
                  if (orderItems.length <= 0)
                    Text(
                      "Nenhum produto adicionado",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  SizedBox(height: 20),
                  FittedBox(
                    child: ElevatedButton(
                      onPressed: () => addProduct(),
                      child: Row(
                        children: [Icon(Icons.add), Text("Adicionar produto")],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    itemCount: orderItems.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) =>
                        OrderItemWidget(orderItems[index], removeItem),
                  )
                ],
              ),
              divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Total: ${formattedTotal(orderTotal)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: ElevatedButton(
                          child: Row(
                            children: [Icon(Icons.save), Text("Salvar pedido")],
                          ),
                          onPressed: () => saveOrder(),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
