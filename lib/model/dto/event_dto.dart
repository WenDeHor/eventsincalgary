class EventDto {
  final String? image;
  final String? phoneContact;
  final String? address;
  final String? date;
  final String? title;
  final String? description;
  final int? userKey;

  const EventDto({
    required this.image,
    required this.phoneContact,
    required this.address,
    required this.date,
    required this.title,
    required this.description,
    required this.userKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'phoneContact': phoneContact,
      'address': address,
      'date': date,
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
          date == other.date &&
          title == other.title &&
          description == other.description &&
          userKey == other.userKey;

  @override
  int get hashCode =>
      image.hashCode ^ phoneContact.hashCode ^ address.hashCode ^ date.hashCode ^ title.hashCode ^ description.hashCode ^ userKey.hashCode;

  @override
  String toString() {
    return 'EventDto{image: $image, phoneContact: $phoneContact, address: $address, data: $date, title: $title, description: $description, userKey: $userKey}';
  }
}
