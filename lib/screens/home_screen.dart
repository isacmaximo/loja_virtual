//Home Screen

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  //controlador das páginas:
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //PageView serve para alternar entre janelas

    return PageView(
      controller: _pageController,
      //não permite que alterne entre telas arrastando para o lado, nó por outra maneira
      physics: NeverScrollableScrollPhysics(),
      //os filhos vão ser as telas
      children: <Widget>[

      ],
    );
  }
}