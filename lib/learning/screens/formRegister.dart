import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../mixins/validation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> with Validation{
  final formKey = GlobalKey<FormState>(); 

  String name = '';
  String email = '';
  String password = '';

  @override 
  Widget build(BuildContext context){
    return Container(
      margin : EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child : Column( 
          children: [
            nameField(),
            emailField(),
            passwordField(),
            registerButton()
          ],
        )
      ),
    );
  }

  Widget nameField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nama Lengkap' //DENGAN LABEL Nama Lengkap
      ),
      validator: validateName, 
      onSaved: (String? value) { 
        name = value.toString();
      },
    );
  }

  Widget emailField(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        labelText : 'Email',
        hintText : 'email@example.com'
      ),
      validator: validateEmail,
      onSaved: (String? value){
        email = value.toString();
      }
    );
  }

  Widget passwordField(){
    return TextFormField(
      obscureText: true, 

      decoration : InputDecoration(
        labelText : 'Password',
        hintText: 'Masukan Password'
      ),

      validator: validatePassword,
      onSaved: (String? value){
        password = value.toString();
      },
    );
  }

  Widget registerButton(){
    return RaisedButton(
      color : Colors.blue[900],
      onPressed: () {
        // formKey.currentState! => Memaksa mengubah type data currentState sesuai dengan yang dibutuhkan 
        
        if (formKey.currentState!.validate()) { //JIKA TRUE
          formKey.currentState?.save(); //MAKA FUN

          print('Nama lengkap: $name');
          print('Email: $email');
          print('Passwor: $password');
        }                
      },      
      child : Text('Kirim')
    );
  }
}
