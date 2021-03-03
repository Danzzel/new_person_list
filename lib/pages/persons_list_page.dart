import 'package:flutter/material.dart';
import 'package:new_person_list/data_base/dataBase.dart';
import 'package:new_person_list/event/serching_person.dart';

import 'package:new_person_list/models/person.dart';

class PersonsListPage extends StatefulWidget {
  @override
  _PersonsListPageState createState() => _PersonsListPageState();
}

class _PersonsListPageState extends State<PersonsListPage> {
  @override
  SearchingPerson searchResult = SearchingPerson();
  // List<Person> _person = PersonList;
  bool isUpdate = false;
  int personIDforUpdate;
  Future<List<Person>> _personsList;
  bool isSearching = false;
 


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

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person’s List'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 350,
              child: TextField(
                controller: _searchController,
                onChanged: (values) {
                  setState(() {
                    if (!_searchController.text.trim().isEmpty) {
                      _personsList = DBProvider.db
                          .selectPerson(values.toLowerCase().trim());
                    } else {
                      _personsList = DBProvider.db.getPersons();
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        if (!_searchController.text.trim().isEmpty) {
                          _personsList = DBProvider.db.selectPerson(
                              _searchController.text.toLowerCase().trim());
                        } else {
                          _personsList = DBProvider.db.getPersons();
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: _personsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return generateList(snapshot.data);
                  }
                  if (snapshot.data == null || snapshot.data.length == 0) {
                    return Text('No Data Found');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  SingleChildScrollView generateList(List<Person> persons) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('LastName'),
            ),
            DataColumn(
              label: Text('DELETE'),
            ),
          ],
          rows: persons
              .map(
                (person) => DataRow(
                  cells: [
                    DataCell(
                      Text(person.name.toString()),
                      // onTap: () {
                      //   setState(() {
                      //     isUpdate = true;
                      //     personIDforUpdate = person.id;
                      //   });

                      // },
                    ),
                    DataCell(
                      Text('${person.lastName}'),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          DBProvider.db.deletePerson(person.id);
                          updatePersonList();
                        },
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
