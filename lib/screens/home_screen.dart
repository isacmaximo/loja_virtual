//Page View

import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

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

        //para ter a aba de navegação precisa estar dentro de um scaffold
        Scaffold(
          body: HomeTab(),
          //widget de navegação
          drawer: CustomDrawer(),
        )


      ],
    );
  }
}
