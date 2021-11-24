
import 'package:flutter/material.dart';
import 'package:t4_topico_usuario_firebase/agregar/agregar_usuario.dart';
import 'package:t4_topico_usuario_firebase/login.dart';
import 'package:t4_topico_usuario_firebase/main.dart';
import 'package:t4_topico_usuario_firebase/menu/animacion_rutas.dart';

class MenuLateral extends StatefulWidget{
  @override
  Menu createState()=>Menu();
}
class Menu extends State<MenuLateral>{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Text(
                "Usuario",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            decoration: BoxDecoration(
              color: Colors.indigo,
              shape: BoxShape.rectangle,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black26,
            ),
            title: Text('Inicio'),
            onTap: (){
              Navigator.push(context, Animacion_rutas(UsuarioApp())).whenComplete(() => Navigator.of(context).pop());
            }
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black26,
            ),
            title: Text('Registrar'),
            onTap: () {
              Navigator.push(context, Animacion_rutas(AgregarUsuario())).whenComplete(() => Navigator.of(context).pop());
            }
          ),
          ListTile(
              leading: Icon(
                Icons.close,
                color: Colors.black26,
              ),
              title: Text('Salir'),
              onTap: () {
                Navigator.push(context, Animacion_rutas(Login())).whenComplete(() => Navigator.of(context).pop());
              }
          ),
        ],
      ),
    );
  }
  
}