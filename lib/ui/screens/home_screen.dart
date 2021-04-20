import 'package:flutter/material.dart';
import 'package:mercos_challenge/ui/screens/clients_screen.dart';
import 'package:mercos_challenge/ui/screens/new_order_screen.dart';
import 'package:mercos_challenge/ui/screens/orders_screen.dart';
import 'package:mercos_challenge/ui/screens/products_screen.dart';
import 'package:mercos_challenge/ui/widgets/drawer/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenIndex = 0;

  /*
   * Foi usado uma estratégia diferente para trocar para a tela de cadastro de pedidos.
   * Não queria usar uma stack de tela (uma tela sobre a outra) e depois dar um pop por
   * conta das dificuldades em passar funções pelos parâmetros.
   */
  List<Map> _screens = [
    {"title": "Pedidos", "screen": OrdersScreen()},
    {"title": "Clientes", "screen": ClientsScreen()},
    {"title": "Produtos", "screen": ProductsScreen()},
  ];

  void selectScreen(int screen) {
    setState(() {
      _screenIndex = screen;
    });
  }

  /*
   * Função para selecionar a tela de pedidos.
   */
  void selectOrderScreen() {
    selectScreen(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*
         * Colocar o botão de voltar na tela de cadastro de pedido.
         */
        leading: _screenIndex == 3
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  selectOrderScreen();
                })
            : null,
        actions: [
          /*
           * Deixar o botão de adicionar pedido visivel somente na tela de pedidos.
           */
          if (_screenIndex == 0)
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  selectScreen(3);
                })
        ],
        /*
         * Modificar o título da página caso seja a tela de cadastro de pedidos.
         */
        title: _screenIndex != 3
            ? Text(_screens[_screenIndex]["title"])
            : Text("Novo Pedido"),
        centerTitle: true,
      ),
      /*
       * Retirar o drawer da tela de cadastro de pedido.
       */
      drawer: _screenIndex != 3 ? MainDrawer(selectScreen) : null,
      /*
       * Override na escolha de telas para o cadastro de pedidos.
       */
      body: _screenIndex != 3
          ? _screens[_screenIndex]["screen"]
          : NewOrderScreen(selectOrderScreen),
    );
  }
}
