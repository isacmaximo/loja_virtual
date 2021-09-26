
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

  //função que  vai atualizar os preços
  void updatePrices(){
    notifyListeners();
  }

  //função que irá retornar o subtotal
  //começa com 0.0
  //para cada um dos produtos , será colocado em c
  //vai pegar a quantidade daquele produto e mutiplicar pelo seu preço, e somar esses ítens
  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData != null){
        price += c.quantity * c.productData.price;
      }
    }
    return price;
  }

  //função que irá retornar o desconto
  //irá pegar o subtotal e aplicar do desconto da porcentagem
  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
  }

  //função que irá retornar o valor da entrega
  double getShipPrice(){
    return 0.00;
  }

  //Função que irá fazer o pedido
  Future<String> finishOrder() async{
    //apenas para não dar problema, uma medida de segurança
    if(products.length == 0){
      return null;
    }

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    //todas as informações necessárias do pedido
    DocumentReference refOrder = await Firestore.instance.collection("orders").add({
      "clientId" : user.firebaseUser.uid,
      "products" : products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shipPrice" : shipPrice,
      "productsPrice" : productsPrice,
      "discount" : discount,
      "totalPrice" : productsPrice + shipPrice - discount,
      "status" : 1
    });

    //colocado a referência do pedido
    await Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("orders").document(refOrder.documentID).setData(
      {
        "orderId" : refOrder.documentID,
      }
    );

    //pegando todos os produtos do carrinho
    QuerySnapshot query = await Firestore.instance.collection("users").
    document(user.firebaseUser.uid).collection("cart").getDocuments();

    //vai pegar cada produto e deletar do carrinho
    for (DocumentSnapshot doc  in query.documents){
      doc.reference.delete();
    }

    //resetando tudo (lista local de produtos no carrinho, cupom de  desconto, percentual de desconto)
    products.clear();

    couponCode = null;

    discountPercentage = 0;

    //indica que já completou
    isLoading = false;

    notifyListeners();

    return refOrder.documentID;
  }

  //função que carregará o carrinho
  void _loadCartItems() async{
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").getDocuments();

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }


}