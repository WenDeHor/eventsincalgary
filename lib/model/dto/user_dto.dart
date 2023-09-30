class UserDto {
  final String? phone;
  final int? userKey;
  final String? email;
  final String? password;
  final String? name;
  final String? image;
  final int? status;

  const UserDto({
    required this.phone,
    required this.userKey,
    required this.email,
    required this.password,
    required this.name,
    required this.image,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'userKey': userKey,
      'email': email,
      'password': password,
      'name': name,
      'image': image,
      'status': status,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDto &&
          runtimeType == other.runtimeType &&
          phone == other.phone &&
          userKey == other.userKey &&
          email == other.email &&
          password == other.password &&
          name == other.name &&
          image == other.image &&
          status == other.status;

  @override
  int get hashCode => phone.hashCode ^ userKey.hashCode ^ email.hashCode ^ password.hashCode ^ name.hashCode ^ image.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'UserDto{phone: $phone, userKey: $userKey, email: $email, password: $password, name: $name, image: $image, status: $status}';
  }
}
