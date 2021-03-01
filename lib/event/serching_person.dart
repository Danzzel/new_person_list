import 'package:new_person_list/models/list.dart';
import 'package:new_person_list/models/person.dart';

class SearchingPerson {
  // String searchPerson;

 List<Person> searchingPerson( String searchPerson) {
    List<Person> result = [];
    // if (searchPerson != null) {
      // for (int i = 0; i < searchPerson.length; i++) {
        for (int j = 0; j < PersonList.length; j++) {
          if (PersonList[j].name.toLowerCase().contains(searchPerson.toLowerCase()) ||
              // searchPerson[i] == 
              PersonList[j].lastName.toLowerCase().contains(searchPerson.toLowerCase()) ) {
            result.add(PersonList[j]);
          }
        }
      // }
    // }
    return result;
  }
}
