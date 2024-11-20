class MeModel {
  String id;
  String name;
  String email;
  String password;
  DateTime createdAt;
  MeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  factory MeModel.fromAPI({required Map<String, dynamic> map}) {
    var userId = map['_id'];
    return MeModel(
      id: userId.oid,
      email: map['email'],
      name: map['name'],
      password: map['password'],
      createdAt: DateTime.tryParse(map['createdAt']) ?? DateTime.now(),
    );
  }
}
