//Widget - Navegador das Páginas

import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {

  //controlador de paginas:
  final PageController _pageController;

  CustomDrawer(this._pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        //gradinte para fazer o degradê no fundo:
          gradient: LinearGradient(
            //passamos a lista de cores para fazer o degradê
              colors: [
                Color.fromARGB(255, 172, 203, 245),
                Colors.white,
              ],
              //aqui vai indicar onde começa e onde termina o degradê:
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
          )
      ),
    );

    //retorna uma "gaveta de janelas"
    return Drawer(
      //stack serve para alinhar os widgets de forma mais específicas, diferente o column que é mais geral
      child: Stack(
        children: <Widget>[
          //fundo da "gaveta de janelas"
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[

                    //nome da loja
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("I.M.\nClothing", style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),),
                    ),

                    //olá
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text("Olá,", style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          ),

                         GestureDetector(
                           child: Text("Entre ou Cadastre-se,", style: TextStyle(
                               color: Theme.of(context).primaryColor,
                               fontSize: 16.0,
                               fontWeight: FontWeight.bold)
                           ),
                           onTap: (){
                             Navigator.of(context).push(
                                 MaterialPageRoute(builder: (context) => LoginScreen()));
                           },
                         )

                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(),
              //widgets dos botões na "gaveta de navegação"
              DrawerTile(Icons.home, "Início", _pageController, 0),
              DrawerTile(Icons.list, "Produtos", _pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", _pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", _pageController, 3),

            ],
          )
        ],
      ),
    );
  }
}
