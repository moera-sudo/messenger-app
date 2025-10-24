class RegRequestModel {
  final String username;
  final String name;
  final String password;
  RegRequestModel({required this.name, required this.password, required this.username});

  Map<String, dynamic> toJson() => {'username' : username, 'name' : name, 'password' : password};
}