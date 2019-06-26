import 'dart:convert';

import 'package:flutter_login/src/share_prefs/prefs_user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _apiKey = 'AIzaSyDJU30XrY6jlWRVfBhSM6zwbBOOEeEc-KA';

  final _prefsUser = new PrefsUser();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_apiKey',
        body: json.encode(authData));
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //salvar el token en el storage
      _prefsUser.token = decodeResp['idToken'];
      return {'OK': true, 'token': decodeResp['idToken']};
    } else {
      return {'OK': false, 'message': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$_apiKey',
        body: json.encode(authData));
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //salvar el token en el storage
      _prefsUser.token = decodeResp['idToken'];

      return {'OK': true, 'token': decodeResp['idToken']};
    } else {
      return {'OK': false, 'message': decodeResp['error']['message']};
    }
  }
}
