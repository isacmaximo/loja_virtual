
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class SingUpScreen extends StatefulWidget {

  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  //controladores:
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  //chave global para acessar o formulário:
  final _formKey = GlobalKey<FormState>();

  //chave global para o scaffold
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Criar Conta"),
          centerTitle: true,
          actions: <Widget>[
          ],
        ),

        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){

            if (model.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }

            else {
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[

                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: "Nome Completo"
                      ),
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Nome Inválido";
                        }
                        else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 16.0,),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "E-mail"
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@")) {
                          return "Email Inválido";
                        }
                        else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 16.0,),

                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                          hintText: "Senha"
                      ),
                      //como é um campo de senha, então não mostra
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6) {
                          return "Senha Inválida!";
                        }
                        else {
                          return null;
                        }
                      },

                    ),

                    SizedBox(height: 16.0,),

                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                          hintText: "Endereço"
                      ),
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Endereço Inválido";
                        }
                        else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 16.0,),

                    SizedBox(
                      height: 44.0,
                      child: ElevatedButton(
                        child: Text("Criar Conta", style: TextStyle(
                          fontSize: 18.0,
                        ),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Theme
                                .of(context)
                                .primaryColor)),

                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _addressController.text,
                            };

                            model.singUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );

            }

          },
        )

    );
  }

  void _onSuccess(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao criar o usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

}

