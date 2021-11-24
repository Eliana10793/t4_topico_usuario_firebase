import 'dart:async';
import 'package:t4_topico_usuario_firebase/agregar/validar.dart';
import 'package:t4_topico_usuario_firebase/listar/listar_usuario.dart';
import 'package:t4_topico_usuario_firebase/menu/animacion_rutas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'listar/usuario.dart';
import 'main.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Login());
}
class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo
      ),
      home: UsuarioLogin(title: 'Login'),
    );
  }
}
class UsuarioLogin extends StatelessWidget{
  final String title;
  UsuarioLogin({required this.title});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
    ));
    return Scaffold(
      body: LoginForm(),
    );
  }
}
class LoginForm extends StatefulWidget{
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}
class LoginFormState extends State<LoginForm>{
  final _formKey=GlobalKey<FormState>();
  var email=TextEditingController();
  var password=TextEditingController();
  validarCampos validar=validarCampos();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            _getContent(),
          ],
        ),
      ),
    );
  }

  Container _getContent(){
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding:
              const EdgeInsets.fromLTRB(15, 250, 15, 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 20.0),
                decoration: InputDecoration(
                  labelText: "Ingrese su Correo",
                  fillColor: Colors.black,
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular((25.0)),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por Favor Ingrese su correo';
                  } else {
                    if (!EmailValidator.validate(value)) {
                      return 'Correo Invalido';
                    } else {
                      return null;
                    }
                  }
                },
                controller: email,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: TextFormField(
                obscureText: true,
                style: TextStyle(fontSize: 20.0),
                decoration: InputDecoration(
                  labelText: "Ingrese su Contraseña",
                  fillColor: Colors.black,
                  prefixIcon: Icon(Icons.enhanced_encryption),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular((25.0)),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Por Favor Ingrese su Contraseña';
                  }else{
                    if(value.length<=5){
                      return 'Por favor Ingrese una Contrseña Mayor a 6 Caracteres';
                    }else{
                      return null;
                    }
                  }
                },
                controller: password,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: MaterialButton(
                minWidth: 200.0,
                height: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                   loginUsuario(context);
                  }
                },
                child: setUpButtonChild(),
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "Login",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    } else
      if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Text(
        "Login",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
  }
  void animateButton(){
    setState(() {
      _state=1;
    });
    Timer(Duration(seconds: 60),(){
      setState(() {
        _state=2;
      });
    });
  }
void loginUsuario(BuildContext context){
    //autenticar
    bool a=true;
    final _auth = FirebaseAuth.instance;
    //base
    final _db = FirebaseFirestore.instance;
    animateButton();
    _auth.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    ).then((value){
      Navigator.push(context, Animacion_rutas(HomePageMain())).whenComplete(() => Navigator.of(context).pop());
    }).catchError((e){
      setState((){
        _state=2;
      });
      Scaffold.of(context)
      // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text(e.message)));
    });
  }

}