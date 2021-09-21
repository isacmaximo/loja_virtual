//Widget - Navegador das Páginas

import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

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
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("I.M.\nClothing", style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              )
            ],

          )
        ],
      ),
    );
  }
}
