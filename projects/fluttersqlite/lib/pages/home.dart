import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttersqlite/pages/contact.dart';
import '../db/database.dart';
import '../models/contact.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DB db = DB();

  List<Contact> contacts = List<Contact>();

  @override
  void initState() {
    super.initState();

    _showContacts();
  }

  void _showContacts() {
    db.findAll().then((items) {
      setState(() {
        contacts = items;
        print("[INFO] CARREGANDO CONTATOS");
        print(contacts);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: <Widget>[
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _onSave();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
            return _buildCard(context, index);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {

    var defaultPathImage = 'assets/images/user-1.png';
    var defaultImage = AssetImage(defaultPathImage);
    var image = contacts[index].image;

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: image != null ? FileImage(File(image)) : defaultImage,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacts[index].name  ?? "",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      contacts[index].email  ?? "",
                      style: TextStyle(fontSize: 15.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  _onDelete(context, contacts[index].id, index);
                },
              ),
            ],
          ),
        ), 
      ),
      onTap: () {
         _onSave(contact: contacts[index]);
      },
    );
  }

  void _onSave({Contact contact}) async {
    var route = MaterialPageRoute(builder: (context) => ContactPage(contact: contact));

    var newContact = await Navigator.push(context, route);

    if(newContact != null) {

      if(contact == null) {
        print("[DEBUG] SAVE NEW CONTACT");
    
        db.insert(newContact).then((id) {
          print("[DEBUG] NOVO CONTATO ADICIONADO");
          print("[INFO] ID: " + id.toString());
        }).catchError((error) {
          print("ERRO: " + error.toString());
        });
      
      } else {
      
        if(_updated(contact, newContact)) {

          db.update(newContact).then((id){
            print("[DEBUG] CONTATO ATUALIZADO");
            print(newContact);
          });

        }
      
      }
      _showContacts();
    }
  }
  
  void _onDelete(BuildContext context, int id, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir contato"),
          content: Text("Deseja excluir este contato permanentemente?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () {
                  setState(() {
                    contacts.removeAt(index);
                    db.delete(id).then((rows) {
                      print("[DEBUG] CONTATO DELETADO");
                      print("[INFO] LINHAS DELETADAS: " + rows.toString());
                    });
                  });
                  Navigator.of(context).pop();
              }, 
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _updated(Contact old, Contact newContact) {
    return old.name != newContact.name || 
      old.email != newContact.email ||
      old.image != newContact.image;
  }
}