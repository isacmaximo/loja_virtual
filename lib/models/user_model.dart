
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//model guarda o estado de alguma coisa, no caso é o login
class UserModel extends Model{

  //autenticação
  FirebaseAuth _auth = FirebaseAuth.instance;

  //usuário que vai estar logado no momento
  FirebaseUser firebaseUser;

  //Mapa que terá os dados mais importantes do usuário
  Map<String,dynamic> userData = Map();

  //indica se está processando alguma coisa
  bool isLoading = false;

  //função vai receber os dados do usuário, uma senha, função que diz se foi um sucesso, função que diz se não deu certo
  //como essa função tem muitos parâmetros, então podemos utilizar o @required para lembrar os parâmetros
  void singUp({@required Map<String,dynamic> userData, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail}){

    //dizendo que está carregando:
    isLoading = true;
    //isso faz com que tudo que esteja dentro do widget ScopedModelDescendant, sejam atualizados/notificados
    notifyListeners();

    //criando usuário no firebase
    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass,

      //se der certo, então ele chama a função que recebe o usuário
    ).then((user) async{
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();

      //se der erro:
    }).catchError((error){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void singIn(){
  }

  void recoverPass(){

  }

  //salvando os dados do usuário
  Future<Null> _saveUserData(Map<String,dynamic> userData) async{
    this.userData = userData;
    //No Firestore: coleção (usuários), documento (id do usuário), setando os dados
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

}