import 'package:flutter/material.dart';
import '../mixins//validation_mixin.dart';
import "dart:convert";
import "package:http/http.dart";

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixing {
  // Habilidade de referenciar um widget específico
  final formKey = GlobalKey<FormState>();

  String email = ''; // expected in server : @a
  String password = ''; // expected in server : 12345678

  String authToken = "";

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        // Widget específico referenciado
        key: formKey, 
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            // Dar um marginTop em relação ao botão submit
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'you@example.com',        
      ),
      // Referenciando a função para validar email
      validator: validateEmail,
      onSaved: (String value) {
          email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Senha',
          hintText: 'Digite sua senha'
      ),
        // Referenciando a função para validar senha
        validator: validatePassword,
        onSaved: (String value) {
          password = value;
        },
  );
}

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {
        // Método para validar os TextFormFields. Se for válido...
        if (formKey.currentState.validate()) {
            // Salvar o que foi digitado
            formKey.currentState.save();
            //doPost();
            //doGet();
            doPatch();
        }  
      },
    );
  }

  // To update user info
  void doPatch() async {
    var request = await patch("http://192.168.10.111:9888/v1/users/users_patch", 
                                headers: {
                                  "Authorization": authToken,
                                }, 
                                body: {
                                  "name":"Jair Messias Bolsonaro",
                                });
    var responseState = json.decode(request.body);
    print(responseState);
  }

  // TO make sign up, sign in, request some operation...
  void doPost() async {
    var request = await post("http://192.168.10.111:9888/v1/users/sign_in",
                               body: {
                                 "email": email,
                                 "password": password
                               });
    var state = json.decode(request.body);
    var givenAuthToken = state["token"]; 
    authToken = givenAuthToken;
    print(state);                               
  }

  // GET data
  void doGet() async {
    var request = await get("http://192.168.10.111:9888/v1/users/user_data", 
                              headers: {
                                "Authorization": authToken,
                              });
    var state = json.decode(request.body);
    print(state);
  }
}
