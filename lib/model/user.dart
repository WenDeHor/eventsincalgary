class User {
  final int? id;
  final String? phone;
  final String? email;
  final String? password;
  final String? name;
  final String? image;

  User(this.id, this.phone, this.email, this.password, this.name, this.image);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'password': password,
      'name': name,
      'image': image,
    };
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
              image == other.image;

  @override
  int get hashCode => id.hashCode ^ phone.hashCode ^ email.hashCode ^ password.hashCode ^ name.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'User{id: $id, phone: $phone, email: $email, password: $password, name: $name, image: $image}';
  }
}