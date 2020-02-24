import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './data/database.dart';
import './pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => AppDatabase(),
      child: MaterialApp(
        title: 'Lista de Tarefas',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),  
    );
  }
}