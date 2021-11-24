import 'package:email_validator/email_validator.dart';

class validarCampos{
  String validarPassword(String value){
  if(value!.isEmpty){
  return 'Por Favor Ingrese su Contraseña';
  }else{
  if(value.length<=5){
  return 'Por favor Ingrese una Contrseña Mayor a 6 Caracteres';
  }
  }
  return '';
}
String validarEmail(String value){
  if (value!.isEmpty) {
    return 'Por Favor Ingrese su correo';
  } else {
    if (!EmailValidator.validate(value)) {
      return 'Correo Invalido';
    }
  }
  return '';
}
}