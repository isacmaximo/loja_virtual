//Classe específica para os dados dos produtos

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  String category;

  String id;
  String title;
  String description;
  double price;

  List images;
  List sizes;

  //construtor
  ProductData.fromDocument(DocumentSnapshot snapshot){
    //pegando a localização de cada campo do firebase
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"] + 0.0; //para aparecer como um valor int
    images = snapshot.data["images"];
    sizes = snapshot.data["sizes"];
  }

  //Resumo das informações do produto
  Map<String,dynamic> toResumedMap(){
    return {
      "title" : title,
      "description" : description,
      "price" : price,
    };
  }

}