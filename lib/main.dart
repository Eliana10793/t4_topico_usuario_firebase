import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t4_topico_usuario_firebase/listar/listar_usuario.dart';

void main() async {
  //inicializar motor flutter
  WidgetsFlutterBinding.ensureInitialized();
  //inicializar firebase
  await Firebase.initializeApp();
  runApp(UsuarioApp());
}
class UsuarioApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Usuario",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      home: HomePageMain(),
      routes: <String, WidgetBuilder>{

      },
    );
  }
}
  class HomePageMain extends StatefulWidget{
  @override
    _BuscarListState createState()=>new _BuscarListState();
}
class _BuscarListState extends State<HomePageMain>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListarUsuario(),
    );
  }

}

