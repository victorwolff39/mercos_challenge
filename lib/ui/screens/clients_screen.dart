import 'package:flutter/material.dart';
import 'package:mercos_challenge/providers/clients_provider.dart';
import 'package:mercos_challenge/ui/widgets/clients/clients_item.dart';
import 'package:provider/provider.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  /*
   * A tela inicia com um indicador de loading, quando termina de pegar
   * os clientes ele é retirado.
   */
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ClientsProvider>(context, listen: false)
        .loadClients()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Pega a lista de clientes do provider.
     */
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final clients = clientsProvider.items;

    return _isLoading
        ? LinearProgressIndicator()
        : Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: clientsProvider.itemsCount(),
        itemBuilder: (ctx, index) => Column(
          children: [
            ClientItem(clients[index]),
            Divider(),
          ],
        ),
      ),
    );
  }
}
