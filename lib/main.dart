import 'package:flutter/material.dart';
import 'package:flutter_login/src/block/provider.dart';
import 'package:flutter_login/src/pages/home_page.dart';
import 'package:flutter_login/src/pages/login_page.dart';
import 'package:flutter_login/src/pages/registry_page.dart';
import 'package:flutter_login/src/share_prefs/prefs_user.dart';

void main() async {
  final prefsUser = new PrefsUser();
  await prefsUser.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'registry': (BuildContext context) => RegistryPage()
      },
      theme: ThemeData(primaryColor: Colors.purple),
    ));
  }
}
