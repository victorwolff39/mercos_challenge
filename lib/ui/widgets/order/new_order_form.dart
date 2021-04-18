import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/ui/widgets/clients/clients_item.dart';
import 'package:mercos_challenge/ui/widgets/order/order_item_widget.dart';
import 'package:mercos_challenge/ui/widgets/order/select_client_button.dart';
import 'package:mercos_challenge/utils/constants/app_routes.dart';

class NewOrderForm extends StatefulWidget {
  @override
  _NewOrderFormState createState() => _NewOrderFormState();
}

class _NewOrderFormState extends State<NewOrderForm> {
  Client client;
  List<OrderItem> orderItems = [];

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
          });
        }
      }
    });
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
                  FittedBox(
                    child: ElevatedButton(
                      onPressed: () => addProduct(),
                      child: Row(
                        children: [Icon(Icons.add), Text("Adicionar produto")],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (orderItems.length <= 0)
                    Text(
                      "Nenhum produto adicionado",
                      style: TextStyle(color: Theme.of(context).primaryColor),
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
            ],
          ),
        ),
      ),
    );
  }
}
