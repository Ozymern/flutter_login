import 'package:flutter/material.dart';

import 'login_bloc.dart';

export 'login_bloc.dart';

//permite mandar informacion desde el padre a sus hijos y sus hijos puedan notificar a sus padres
class Provider extends InheritedWidget {
  //singleton  que la primera vez reciba informacion y la segunda la devuelva
  static Provider _instance;

//determinar si necesito regresar una nueva instancia de la clase o reocupar la existente
  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);
  final loginBloc = LoginBloc();

  //Key identificador unico del Widget
  // Provider({Key key, Widget child}) : super(key: key, child: child);

  //al actualizarse debe notificar a sus hijos?
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  //va a buscar en el arbol de widget y me retornara la instancia de mi login bloc
  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .loginBloc;
  }
}
