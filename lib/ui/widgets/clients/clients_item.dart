import 'package:flutter/material.dart';
import '../../../models/client.dart';

class ClientItem extends StatelessWidget {
  final Client client;

  ClientItem(this.client);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: constraints.maxWidth * 0.20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(client.id.toString()),
                SizedBox(
                  width: 10,
                ),
                if (constraints.maxWidth >= 600)
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
                        image: client.imageUrl != null
                            ? NetworkImage(client.imageUrl)
                            : AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Container(
            alignment: Alignment.centerLeft,
            width: constraints.maxWidth * 0.20,
            child: Text(client.name),
          ),
        ],
      );
    });
  }
}
