class Company {
  final String id;
  final String name;
  final String catchPhrase;
  final String bs;

  Company({this.id, this.name, this.catchPhrase, this.bs});

  factory Company.fromJson(dynamic json) {
    return Company(
      id: json['id'],
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}
