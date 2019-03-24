import './company.dart';

class User {
  final String id;
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  final List<Company> companies;

  User(
      {this.id,
      this.username,
      this.first_name,
      this.last_name,
      this.email,
      this.phone,
      this.companies});

  factory User.fromJson(dynamic json) {
    final List<dynamic> rawCompanies = json['companies'];
    final List<Company> companies =
        rawCompanies.map((dynamic company) => Company.fromJson(company)).toList();
    return User(
      id: json['id'],
      username: json['username'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      companies: companies,
    );
  }
}
