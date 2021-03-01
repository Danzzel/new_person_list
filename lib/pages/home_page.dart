import 'package:flutter/material.dart';
import 'package:new_person_list/models/person.dart';
import 'package:new_person_list/models/persons_list.dart';
import 'package:new_person_list/pages/persons_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();



  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new person'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Form(
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Enter person’s name',
                  prefixIcon: Icon(Icons.person)),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                  labelText: 'Enter person’s last name',
                  prefixIcon: Icon(Icons.person)),
            ),
            RaisedButton(
                padding: EdgeInsets.all(0),
                color: Colors.lightBlue,
                onPressed: () {
                  if (!_lastNameController.text.isEmpty  && !_nameController.text.isEmpty) {
                    AddPerson(
                        name: _nameController.text,
                        lastName: _lastNameController.text);
                    _clearTextFormField();
                  }
                  ;
                },
                child: Text('Add Person')),
            RaisedButton(
                padding: EdgeInsets.all(0),
                color: Colors.lightBlue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonsListPage()));
                },
                child: Text('Go to Person’s List')),
          ],
        ),
      ),
    );
  }

  _clearTextFormField() {
    _lastNameController.clear();
    _nameController.clear();
  }
}
