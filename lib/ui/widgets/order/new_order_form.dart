import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/ui/widgets/clients/client_selection_dialog.dart';

class NewOrderForm extends StatefulWidget {
  @override
  _NewOrderFormState createState() => _NewOrderFormState();
}

class _NewOrderFormState extends State<NewOrderForm> {
  /*
   * Popup no dialog, passando o BuildContext. O dialog usa o Navigator.of para
   * retornar a opção.
   */
  Future<Client> _showClientSelectionDialog(BuildContext context) async {
    Client client = await showDialog<Client>(
            context: context,
            builder: (BuildContext context) => ClientSelectionDialog())
        .then((value) {
      return value;
    });
    if (client != null) {
      print(client.name);
    }
    return client;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: TextButton(
        onPressed: () {
          _showClientSelectionDialog(context);
        },
        child: Text("Add client"),
      ),
    );
  }
}
