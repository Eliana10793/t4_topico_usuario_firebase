import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t4_topico_usuario_firebase/listar/usuario.dart';
import 'package:t4_topico_usuario_firebase/menu/menu_lateral.dart';


class ListarUsuario extends StatefulWidget{
  @override
  ListUsuarioState createState()=>ListUsuarioState();
}
class ListUsuarioState extends State<ListarUsuario>{
  final _refreshKey= GlobalKey <RefreshIndicatorState>();
  final _db= FirebaseFirestore.instance;
  late List <Usuarios> listUsuario;
  late Widget _usuario;
  @override
  void initState(){
    super.initState();
    Firebase.initializeApp();
    listUsuario =List<Usuarios>.empty(growable: true);
    _usuario= SizedBox();
    leerDato();
  }
  Widget appBarTitle = Text(
    "Buscar Usuario",
    style: TextStyle(color: Colors.white),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: [

        ],
      ),
      drawer: MenuLateral(),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: leerDato,
        child: ListView(
          children: [
            _usuario
          ],
        ),
      ),
    );
  }
  Future<void> leerDato()async{
    Stream<QuerySnapshot> qf=_db.collection('Usuario').snapshots();
    qf.listen((QuerySnapshot Dato) =>{
      listUsuario.clear(),
      Dato.docs.map((doc) => {
        listUsuario.add(Usuarios(
            doc.get('Apellido'),
            doc.get('Nombre'),
            doc.id,
        )),
      }).toList(),
      usuarioList(""),
    });
  }
  Container buildItem(Usuarios doc){
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: Stack(
        children: [
          card(doc),
        ],
      ),
    );
  }
  GestureDetector card(Usuarios doc){
    return GestureDetector(
      child: Container(
        height: 130.0,
        margin: EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(0.0,5.0),
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${doc.Nombre}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '${doc.Apellido}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '${doc.Email}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
  void usuarioList(String buscarTexto){
    setState(() {
      if(listUsuario!=null){
        if(buscarTexto==null ||buscarTexto==""){
          _usuario= Column(
            children: listUsuario.map((user) => buildItem(user)).toList(),
          );
        }else{
          var usuario=listUsuario.where((element) => element.Nombre.startsWith(buscarTexto)).toList();
          if(0<usuario.length){
            _usuario= Column(
              children: usuario.map((user) => buildItem(user)).toList(),
            );
          }else{
            _usuario =SizedBox();
          }
        }
      }else{
        _usuario=SizedBox();
      }
    });

  }

}