import 'package:flare_test/hello_man_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flare Demo - penguin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HelloManPage(),
    );
  }
}
