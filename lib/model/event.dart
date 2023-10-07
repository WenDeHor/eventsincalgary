class Event {
  final int? id;
  final String? image;
  final String? phoneContact;
  final String? address;
  final String? date;
  final String? title;
  final String? description;
  final int? userKey;

  const Event({this.id, this.image, this.phoneContact, this.address, this.date, this.title, this.description, this.userKey});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'phoneContact': phoneContact,
      'date': date,
      'title': title,
      'description': description,
      'userKey': userKey,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
        id: map['id'] as int,
        image: map['image'] as String,
        phoneContact: map['phone_contact'] as String,
        address: map['address'] as String,
        date: map['date'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        userKey: map['user_key'] as int);
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
          date == other.date &&
          title == other.title &&
          description == other.description &&
          userKey == other.userKey;

  @override
  int get hashCode =>
      id.hashCode ^
      image.hashCode ^
      phoneContact.hashCode ^
      address.hashCode ^
      date.hashCode ^
      title.hashCode ^
      description.hashCode ^
      userKey.hashCode;

  @override
  String toString() {
    return 'Event{id: $id, image: $image, phoneContact: $phoneContact, address: $address, data: $date, title: $title, description: $description, userKey: $userKey}';
  }
}
