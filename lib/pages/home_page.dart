import 'package:flutter/material.dart';
import 'package:new_person_list/data_base/dataBase.dart';
import 'package:new_person_list/models/person.dart';
// import 'package:new_person_list/models/person.dart';
// import 'package:new_person_list/models/persons_list.dart';
import 'package:new_person_list/pages/persons_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();

  Future<List<Person>> _personsList;
  String _personName;
  String _personLastName;
  int personIDforUpdate;
  bool isUpdate = false;

  @override
  void initState() {
    updatePersonList();
    super.initState();
  }

  updatePersonList() {
    setState(() {
      _personsList = DBProvider.db.getPersons();
    });
  }

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
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Person Name';
                }
                if (value.trim() == "") return "Only Space is Not Valid!!!";
                return null;
              },
              controller: _nameController,
              onSaved: (value) {
                _personName = value;
              },
              decoration: InputDecoration(
                  labelText: 'Enter person’s name',
                  prefixIcon: Icon(Icons.person)),
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Person Last Name';
                }
                if (value.trim() == "") return "Only Space is Not Valid!!!";
                return null;
              },
              controller: _lastNameController,
              onSaved: (value) {
                _personLastName = value;
              },
              decoration: InputDecoration(
                  labelText: 'Enter person’s last name',
                  prefixIcon: Icon(Icons.person)),
            ),
            RaisedButton(
                padding: EdgeInsets.all(0),
                color: Colors.lightBlue,
                onPressed: () {
                  if (isUpdate) {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      DBProvider.db
                          .updatePerson(Person(
                              personIDforUpdate, _personLastName, _personName))
                          .then((data) {
                        setState(() {
                          isUpdate = true;
                        });
                      });
                    }
                  } else {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      DBProvider.db.insertPerson(
                          Person(null, _personLastName, _personName));
                    }
                  }
                  _clearTextFormField();
                  updatePersonList();
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
