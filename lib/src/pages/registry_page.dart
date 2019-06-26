import 'package:flutter/material.dart';
import 'package:flutter_login/src/block/provider.dart';
import 'package:flutter_login/src/services/user_service.dart';
import 'package:flutter_login/src/utils/utils.dart' as utils;

class RegistryPage extends StatelessWidget {
  final userService = new UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _registryForm(context),
        ],
      ),
    );
  }

  Widget _registryForm(BuildContext context) {
    //este bloc es una unica instancia gracias a mi metodo of
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    //SingleChildScrollView me permitira hacer scroll dependiendo de todo lo alto que tenga su hijo
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0))
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Crear Cuenta',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _createEmail(bloc),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                _createPassword(bloc),
                _createBtn(bloc)
              ],
            ),
          ),
          FlatButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: Text('ya posees cuenta?')),
          SizedBox(
            height: 80.0,
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.pinkAccent,
                ),
                hintText: 'ejemplo@correo.com',
                helperText: 'Correo electronico',
                errorText: snapshot.error,
                counterText: snapshot.data,
              ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _createBtn(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidateStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            onPressed:
                (snapshot.hasData) ? () => _registry(bloc, context) : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 1.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
          );
        });
  }

//metodo se ejecuta cuando tiene informacion correcta en los campos email y password
  _registry(LoginBloc bloc, BuildContext context) async {
    Map info =
        await userService.newUser(bloc.lastValueEmail, bloc.lastValuePassword);
    if (info['OK']) {
      //pushReplacementNamed esta pagina va hacer mi nuevo root
      Navigator.pushReplacementNamed(context, 'home', arguments: bloc);
    } else {
      utils.showAlert(context, info['message']);
    }
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.pinkAccent,
                  ),
                  labelText: 'Contraseña',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _createBackground(BuildContext context) {
//obtener las dimensiones de la pantalla
    final size = MediaQuery.of(context).size;
    final backGroundPurple = Container(
      //obtener el 40% de la pantalla
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Colors.purple, Colors.purpleAccent])),
    );

    //crear circulos
    final circle = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.09)),
    );

    return Stack(
      children: <Widget>[
        backGroundPurple,
        //cambiar la pisicion del circulo
        Positioned(
          child: circle,
          top: 80.0,
          left: 20.0,
        ),
        Positioned(
          child: circle,
          top: -40.0,
          right: -30.0,
        ),
        Positioned(
          child: circle,
          bottom: -50.0,
          right: 20.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 45.0),
          child: Column(
            //la columna se va a estirar por defecto de cual es el hijo que tiene mayor width, por consecuencia todo lo centrara
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 90.0,
              ),
              SizedBox(
                height: 8.0,
                width: double.infinity,
              ),
              Text(
                'Alejandro Fernández',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }
}
