class User{
  int id;

  User.fromJson(Map<String, dynamic> json) :
        id = json['id']
  ;

  Map<String, dynamic> toJson() => {
    'id': id,
  };

  @override
  String toString() {
    return 'User{id: $id}';
  }
}