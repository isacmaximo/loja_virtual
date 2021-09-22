//Widgets

import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String  text;

  DrawerTile(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    //Está retornando o Material, pois queremos um efeito visual ao clicar no widget
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){

        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              //configuração geral dos ícones
              Icon(icon, size: 32.0, color: Colors.black,),
              //espaçamento lateral
              SizedBox(width: 32),
              Text(text, style: TextStyle(fontSize: 16.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
