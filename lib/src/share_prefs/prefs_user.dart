import 'package:shared_preferences/shared_preferences.dart';

class PrefsUser {
//patron singleton

  static final PrefsUser _prefsUser = new PrefsUser._internal();

//cuando se enecute en constructor por defecto , retornara la instancia
  factory PrefsUser() {
    return _prefsUser;
  }

  PrefsUser._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //GET y SET

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get lastPage {
    return _prefs.getString('lastPage') ?? '/';
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }
}
