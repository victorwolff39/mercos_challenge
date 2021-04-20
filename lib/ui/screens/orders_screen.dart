import 'package:flutter/material.dart';
import 'package:mercos_challenge/providers/orders_provider.dart';
import 'package:mercos_challenge/ui/widgets/order/order_widget.dart';
import 'package:provider/provider.dart';
import 'package:mercos_challenge/utils/constants/app_routes.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false)
        .loadOrders()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.items;

    return _isLoading
        ? LinearProgressIndicator()
        : orders.length > 0
            ? ListView.builder(
                itemCount: ordersProvider.itemsCount(),
                itemBuilder: (ctx, index) => Column(
                  children: [
                    OrderWidget(orders[index]),
                    //Text(orders[index].id != null ? orders[index].id : "default"),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Nenhum pedido cadastrado",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: 20),
                    FittedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed(AppRoutes.NEW_ORDER);
                        },
                        child: Row(
                          children: [Icon(Icons.add), Text("Adicionar pedido")],
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}
