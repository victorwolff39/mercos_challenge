import 'package:flutter/material.dart';
import 'package:mercos_challenge/ui/widgets/order/new_order_form.dart';

class NewOrderScreen extends StatefulWidget {
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo pedido"),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: NewOrderForm(),
    );
  }
}
