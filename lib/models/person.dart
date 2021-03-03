class Person {
  String name;
  String lastName;
  int id;
  Person(this.id, this.lastName, this.name);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['lastName'] = lastName;
    return map;
  }

  Person.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    lastName = map['lastName'];
  }
}
