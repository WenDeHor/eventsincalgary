class Event {
  final int? id;
  final String? image;
  final String? phoneContact;
  final String? data;
  final String? title;
  final String? description;


  Event(this.id, this.image, this.phoneContact, this.data, this.title, this.description);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'phoneContact': phoneContact,
      'data': data,
      'title': title,
      'description': description,
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
          data == other.data &&
          title == other.title &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ image.hashCode ^ phoneContact.hashCode ^ data.hashCode ^ title.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'Event{id: $id, image: $image, phoneContact: $phoneContact, data: $data, title: $title, description: $description}';
  }
}