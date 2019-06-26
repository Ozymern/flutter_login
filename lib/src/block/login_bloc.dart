import 'dart:async';

import 'package:flutter_login/src/block/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  // broadcast-> varias instancias puedan estar escuchando esos cambios
  //los StreamController no existen en rx, sino los BehaviorSubject
//  final _emailController = StreamController<String>.broadcast();
//
//  final _passwordController = StreamController<String>.broadcast();

  final _emailController = BehaviorSubject<String>();

  final _passwordController = BehaviorSubject<String>();

  //optener el ultimo valor emitido
  String get lastValueEmail => _emailController.value.trim();
  String get lastValuePassword => _passwordController.value;

  //get y set
//insertar valores al stream
//no agrego los () porque no se estara ejecutando, solo mandando la referencia
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //escuchar los cambios
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  //conbinar stream e, p) ->email y password
  Stream<bool> get formValidateStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //cerrar el stream
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
