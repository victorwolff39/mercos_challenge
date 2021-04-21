import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/clients_provider.dart';

class ClientSelectionDialog extends StatefulWidget {
  @override
  _ClientSelectionDialogState createState() => _ClientSelectionDialogState();
}

class _ClientSelectionDialogState extends State<ClientSelectionDialog> {
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

    return SimpleDialog(
      title: Text("Selecione o cliente:"),
      children: [
        _isLoading
            ? LinearProgressIndicator()
            : Container(
                height: 400,
                width: 300,
                child: ListView.builder(
                  itemCount: clientsProvider.itemsCount(),
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(clients[index].imageUrl),
                        ),
                        title: Text(clients[index].name),
                        subtitle: Text("ID: ${clients[index].id.toString()}"),
                        onTap: () {
                          Navigator.pop(context, clients[index]);
                        },
                      )
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
