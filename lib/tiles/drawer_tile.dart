//Características Gerais dos Widgets de Navegação

import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  //(ícone, texto, controlador, número da página)
  final IconData icon;
  final String  text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    //Está retornando o Material, pois queremos um efeito visual ao clicar no widget
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          //fecha a gaveta de navegação
          Navigator.of(context).pop();
          //ao clicar ele vai para a página
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[

              //configuração geral dos ícones
              Icon(icon,
                size: 32.0,
                //se estiver na página atual for igual a página do ítem então fica com a cor primária, se não fica cinza
                color: controller.page.round() == page ?
                Theme.of(context).primaryColor : Colors.grey[700],
              ),

              //espaçamento lateral
              SizedBox(width: 32),

              //texto
              Text(text,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: controller.page.round() == page ?
                      Theme.of(context).primaryColor : Colors.grey[700],
                  ))

            ],
          ),
        ),
      ),
    );
  }
}
