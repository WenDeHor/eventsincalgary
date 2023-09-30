class EventDto {
  final String? image;
  final String? phoneContact;
  final String? address;
  final String? data;
  final String? title;
  final String? description;
  final int? userKey;

  const EventDto({
    required this.image,
    required this.phoneContact,
    required this.address,
    required this.data,
    required this.title,
    required this.description,
    required this.userKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'phoneContact': phoneContact,
      'address': address,
      'data': data,
      'title': title,
      'description': description,
      'userKey': userKey,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventDto &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          phoneContact == other.phoneContact &&
          address == other.address &&
          data == other.data &&
          title == other.title &&
          description == other.description &&
          userKey == other.userKey;

  @override
  int get hashCode =>
      image.hashCode ^ phoneContact.hashCode ^ address.hashCode ^ data.hashCode ^ title.hashCode ^ description.hashCode ^ userKey.hashCode;

  @override
  String toString() {
    return 'EventDto{image: $image, phoneContact: $phoneContact, address: $address, data: $data, title: $title, description: $description, userKey: $userKey}';
  }
}
