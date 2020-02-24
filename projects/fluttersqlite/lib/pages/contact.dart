import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttersqlite/models/contact.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => new _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  bool updated = false;
  Contact _form;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null) {
      _form = Contact(id: null, name: "", email: "", image: null); 
    } else {
      _form = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _form.name;
      _emailController.text = _form.email;
    }
  }

  @override
  Widget build(BuildContext context) {

    var title = _form.name.isEmpty ? "Novo Contato" : _form.name;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          var isValid = true;

          if(_form.name == null || _form.name.isEmpty) {

            isValid = false;
            _showAlert(title: "Nome", content: "Nome não pode ser vazio");
            FocusScope.of(context).requestFocus(_nameFocus);

          } else if(_form.email == null || _form.email.isEmpty) {

            isValid = false;
            _showAlert(title: "Email", content: "Email não pode ser vazio!");
            FocusScope.of(context).requestFocus(_emailFocus);

          }

          if(isValid) {
            Navigator.pop(context, _form);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            _buildImage(),
            _buildInput(_nameController, "Nome"),
            _buildInput(_emailController, "Email"),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    var defaultPathImage = 'assets/images/user-2.png';
    var defaultImage = AssetImage(defaultPathImage);
    var image = _form.image;

    return GestureDetector(
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: _form.image != null ? FileImage(File(image)) : defaultImage,
          ),
        ),
      ),
      onTap: () {
        ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
          if(file != null) {
            setState(() {
              _form.image = file.path;
            });
          }
        });
      },
    );
  }

  Widget _buildInput(TextEditingController inputController, String label) {

    var isNameInput = label == "Nome";
    var inputType = isNameInput ? TextInputType.text : TextInputType.emailAddress;
    var inputFocus = isNameInput ? _nameFocus : _emailFocus;

    return TextField(
      controller: inputController,
      decoration: InputDecoration(labelText: label),
      focusNode: inputFocus,
      onChanged: (value) {
        updated = true;
        setState(() {
          if(isNameInput) {
            _form.name = value;
          } else {
            _form.email = value;
          }
        });

      },
      keyboardType: inputType,
    );
  }

  void _showAlert({String title, String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}

