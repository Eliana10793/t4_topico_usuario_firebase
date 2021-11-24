
import 'package:flutter/cupertino.dart';

class Animacion_rutas extends PageRouteBuilder{
  final Widget widget;
  //Constructor
  Animacion_rutas(this.widget): super(
    transitionDuration: const Duration(
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0,
      milliseconds: 500,
      microseconds: 0,
    ),
    //Establecer las Rutas
    pageBuilder: (BuildContext context, Animation<double> animation1,
        Animation<double>animation2){
      return widget;
    },
      //Animacion a la Nueva Ruta
    transitionsBuilder: (BuildContext context,
    Animation<double> animation1,
    Animation<double> animation2,
    Widget child){
      return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1.0, 0.0),
              end: Offset(0.0, 0.0)
          ).animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
        child: child,
      );
    }
  );

}