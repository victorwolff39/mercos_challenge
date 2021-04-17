import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/ui/widgets/clients/clients_item.dart';
import 'package:mercos_challenge/ui/widgets/order/select_client_button.dart';
import 'package:mercos_challenge/utils/constants/app_routes.dart';

class NewOrderForm extends StatefulWidget {
  @override
  _NewOrderFormState createState() => _NewOrderFormState();
}

class _NewOrderFormState extends State<NewOrderForm> {
  Client client;
  List<OrderItem> orderItems;

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  Text(
                    "Nenhum produto adicionado",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        /*
                         * arguments: true é para permitir a seleção no ProductItem.
                         */
                        Navigator.of(context).pushNamed(AppRoutes.SELECT_PRODUCT, arguments: true);
                      },
                      child: Row(
                        children: [Icon(Icons.add), Text("Adicionar produto")],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
