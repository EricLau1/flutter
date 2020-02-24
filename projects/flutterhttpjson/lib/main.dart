import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterhttpjson/api.dart';
import 'package:flutterhttpjson/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter-Http-Json',
      home: BuildListView(),
    );
  }
}

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => new _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {

  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      Iterable items = json.decode(response.body);
      users = items.map((model) => User.fromJson(model)).toList();
      users.forEach((u) => print(u.name));
    });
  }

  _BuildListViewState() {
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].name),
        );
      },
    );
  }
}