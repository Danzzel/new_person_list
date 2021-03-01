import 'package:flutter/material.dart';
import 'package:new_person_list/event/serching_person.dart';
import 'package:new_person_list/models/list.dart';
import 'package:new_person_list/models/person.dart';

class PersonsListPage extends StatefulWidget {
  @override
  _PersonsListPageState createState() => _PersonsListPageState();
}

class _PersonsListPageState extends State<PersonsListPage> {
  @override
  SearchingPerson searchResult = SearchingPerson();
  List<Person> _person = PersonList;

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _person.sort((a, b) {
      return a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Person’s List'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Container(
            width: 350,
            child: TextField(
              onChanged: (value) {
                _person = searchResult.searchingPerson(_searchController.text);
                setState(() {});
              },
              controller: _searchController,
              decoration: InputDecoration(hintText: 'Search...'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _person.length,
                itemBuilder: (BuildContext context, int index) {
                  if (PersonList.isEmpty) {
                    return Text('List is Empty');
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 4, right: 10, bottom: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Name: ${_person[index].name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              height: 4,
                              color: Colors.red,
                            ),
                            Text('Last name: ${_person[index].lastName}'),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
