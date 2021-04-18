import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/ui/widgets/clients/client_selection_dialog.dart';

class SelectClientButton extends StatelessWidget {
  final Function(Client client) selectClient;
  final Client client;

  SelectClientButton(
    this.selectClient,
    this.client,
  );

  /*
   * Popup no dialog, passando o BuildContext. O dialog usa o Navigator.of para
   * retornar a opção.
   */
  void _showClientSelectionDialog(BuildContext context) async {
    Client client = await showDialog<Client>(
            context: context,
            builder: (BuildContext context) => ClientSelectionDialog())
        .then((value) {
      return value;
    });
    selectClient(client);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text(
              "Nenhum cliente selecionado",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 20),
            FittedBox(
              child: ElevatedButton(
                onPressed: () {
                  _showClientSelectionDialog(context);
                },
                child: Row(
                  children: [Icon(Icons.add), Text("Selecionar cliente")],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
