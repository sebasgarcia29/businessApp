import 'package:flutter/material.dart';

//Provider
import 'package:formvalidation/src/bloc/provider.dart';

//Pages
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'product': (BuildContext context) => ProducPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    ));
  }
}
