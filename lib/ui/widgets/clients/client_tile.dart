import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/client.dart';

class ClientTile extends StatelessWidget {
  final Client client;

  ClientTile(this.client);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(client.imageUrl),
      ),
      title: Text(client.name),
      subtitle: Text("ID: ${client.id.toString()}"),
    );
  }
}
