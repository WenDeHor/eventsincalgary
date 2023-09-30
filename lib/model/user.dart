class User {
  final int? id;
  final String? phone;
  final int? userKey;
  final String? email;
  final String? password;
  final String? name;
  final String? image;
  final int? status;

  User.name(this.id, this.phone, this.userKey, this.email, this.password, this.name, this.image, this.status);

  //  User(this.id, this.phone, this.email, this.password, this.name, this.image, this.status);

  const User({this.id, this.phone, this.userKey, this.email, this.password, this.name, this.image, this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'userKey': userKey,
      'email': email,
      'password': password,
      'name': name,
      'image': image,
      'status': status,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as int,
        phone: map['phone'] as String,
        userKey: map['userKey'] as int,
        email: map['email'] as String,
        password: map['password'] as String,
        name: map['name'] as String,
        image: map['image'] as String,
        status: map['status'] as int);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          phone == other.phone &&
          email == other.email &&
          password == other.password &&
          name == other.name &&
          image == other.image &&
          status == other.status;

  @override
  int get hashCode => id.hashCode ^ phone.hashCode ^ email.hashCode ^ password.hashCode ^ name.hashCode ^ image.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'User{id: $id, phone: $phone, email: $email, password: $password, name: $name, image: $image, status: $status}';
  }
}
