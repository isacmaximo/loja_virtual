
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  UserModel user;

  //lista de produtos:
  List<CartProduct> products = [];

  //cupon e desconto
  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user){
    //se o usuário estiver logado, então ele carrega o carrinho
   if (user.isLoggedIn()){
    _loadCartItems();
   }
  }

  //método estático é um método da classe e não do objeto
  //faremos isso pois vai precisar para o sistema do carrinho
  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  //função para adicionar ítens no carrinho:
  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").add(cartProduct.toMap()).then((doc){
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  //função para remover ítens no carrinho:
  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").document(cartProduct.cid).delete();
    
    products.remove(cartProduct);

    notifyListeners();
  }

  //função que vai decrementar a quantidade de ítens de um determinado produto no carrinho
  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  //função que vai incrementar a quantidade de ítens de um determinado produto no carrinho
  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  //função que vai salvar o cupom de desconto (código) e seu percentual de desconto
  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  //função que carregará o carrinho
  void _loadCartItems() async{
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").getDocuments();

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }


}