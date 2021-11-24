
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t4_topico_usuario_firebase/main.dart';
import 'package:t4_topico_usuario_firebase/menu/animacion_rutas.dart';
import 'package:t4_topico_usuario_firebase/menu/menu_lateral.dart';

void main() => runApp(AgregarUsuario());

class AgregarUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light, primarySwatch: Colors.indigo),
        darkTheme: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.indigo),
        home: HomePage(title: 'Registrar'),
        routes: <String, WidgetBuilder>{});
  }
}

class HomePage extends StatelessWidget {
  final String title;
  HomePage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(context, Animacion_rutas(UsuarioApp()))
                    .whenComplete(() => Navigator.of(context).pop());
              }),
          SizedBox(width: 10)
        ],
      ),
      body: UsuarioForm(),
      drawer: MenuLateral(),
    );
  }
}

class UsuarioForm extends StatefulWidget {
  @override
  UsuarioFormState createState() {
    return UsuarioFormState();
  }
}

class UsuarioFormState extends State<UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  var nombre = TextEditingController();
  var apellido = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: "Ingrese su Nombre",
                fillColor: Colors.black,
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular((25.0)),
                  borderSide: BorderSide(),
                ),
              ),
              //ignore: missing_return
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por Favor Ingrese su Nombre';
                }
              },
              controller: nombre,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: "Ingrese su Apellido",
                fillColor: Colors.black,
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular((25.0)),
                  borderSide: BorderSide(),
                ),
              ),
              //ignore: missing_return
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por Favor Ingrese su Apellido';
                }
              },
              controller: apellido,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registrar(context);
                }
              },
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: setUpButtonChild(),
            ),
          ),
        ],
      ),
    );
  }

  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "Registrar",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Text(
        "Registrar",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
  }

    registrar(BuildContext context) async{
      //autenticar
      final _auth = FirebaseAuth.instance;
      //almacenar
      //final _firebaseStorage = FirebaseStorage.instance;
      //base
      final _db = FirebaseFirestore.instance;
      //crear usuario
      await _auth.createUserWithEmailAndPassword(
        email: email.text, 
        password: password.text,
        ).then((value){
          DocumentReference ref = _db.collection('Usuario').doc(email.text);
          ref.set({'Nombre':nombre.text, 'Apellido':apellido.text})
          .then((value){
            Navigator.push(context, Animacion_rutas(HomePageMain())).whenComplete(() => Navigator.of(context).pop());
          });

        }).catchError((e){
          Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text(e.message)));
        });
    }
  }

