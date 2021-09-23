//Características Gerais dos Widgets da Lista de Categorias (Produtos)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //leading são os ícones que vão ficar na esquerda
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["title"]),
      //ícone que fica no final
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        //ao clicar em um dos widgets que tem a categoria, será direcionado para a tela dos ítens dessa categoria
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoryScreen(snapshot))
        );
      },
    );
  }
}
