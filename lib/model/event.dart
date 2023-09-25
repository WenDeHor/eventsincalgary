class Event {
  final int? id;
  final String? image;
  final String? phoneContact;
  final String? address;
  final String? data;
  final String? title;
  final String? description;
  final String? userKey;

  Event(this.id, this.image, this.phoneContact, this.address, this.data, this.title, this.description, this.userKey);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'phoneContact': phoneContact,
      'data': data,
      'title': title,
      'description': description,
      'userKey': userKey,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          image == other.image &&
          phoneContact == other.phoneContact &&
          address == other.address &&
          data == other.data &&
          title == other.title &&
          description == other.description &&
          userKey == other.userKey;

  @override
  int get hashCode =>
      id.hashCode ^
      image.hashCode ^
      phoneContact.hashCode ^
      address.hashCode ^
      data.hashCode ^
      title.hashCode ^
      description.hashCode ^
      userKey.hashCode;

  @override
  String toString() {
    return 'Event{id: $id, image: $image, phoneContact: $phoneContact, address: $address, data: $data, title: $title, description: $description, userKey: $userKey}';
  }
}
