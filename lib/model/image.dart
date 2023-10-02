class ImageEvent {
  final int? id;
  final String? image;

  ImageEvent.name(this.id, this.image);

  const ImageEvent({this.id, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory ImageEvent.fromMap(Map<String, dynamic> map) {
    return ImageEvent(
        id: map['id'] as int,
        image: map['image'] as String);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ImageEvent && runtimeType == other.runtimeType && id == other.id && image == other.image;

  @override
  int get hashCode => id.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'Image{id: $id, image: $image}';
  }


}
