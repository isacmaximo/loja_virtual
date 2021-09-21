//APP - Loja Virtual

//plugins necessários para o projeto:
//flutter_staggered_grid_view: ^0.3.0
// cloud_firestore: ^0.12.9
// carousel_pro: ^1.0.0
// transparent_image: ^1.0.0
// scoped_model: ^1.0.1
// firebase_auth: ^0.11.1+12
// url_launcher: ^5.1.1

//necessário utilizar o Firebase
//métoto de login por email e senha

//libraries necessárias:
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';



//função principal
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Loja Virtual",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //podemos definir a cor primária pelo rgb,
          //onde podemos configurar (opacidade, vermelho, verde, azul)
        primaryColor: Color.fromARGB(255, 4, 125, 141)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

}