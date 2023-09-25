class Ticket {
  final int? id;
  final int? eventId;
  final int? userId;
  final String? userPhone;
  final String? userName;
  final String? userTicketNumber;
  final String? dataEvent;
  final String? address;
  final String? titleEvent;
  final String? descriptionEvent;

  Ticket(this.id, this.eventId, this.userId, this.userPhone, this.userName, this.userTicketNumber, this.dataEvent, this.address, this.titleEvent,
      this.descriptionEvent);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'userId': userId,
      'userPhone': userPhone,
      'userName': userName,
      'userTicketNumber': userTicketNumber,
      'dataEvent': dataEvent,
      'address': address,
      'titleEvent': titleEvent,
      'descriptionEvent': descriptionEvent,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ticket &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          eventId == other.eventId &&
          userId == other.userId &&
          userPhone == other.userPhone &&
          userName == other.userName &&
          userTicketNumber == other.userTicketNumber &&
          dataEvent == other.dataEvent &&
          address == other.address &&
          titleEvent == other.titleEvent &&
          descriptionEvent == other.descriptionEvent;

  @override
  int get hashCode =>
      id.hashCode ^
      eventId.hashCode ^
      userId.hashCode ^
      userPhone.hashCode ^
      userName.hashCode ^
      userTicketNumber.hashCode ^
      dataEvent.hashCode ^
      address.hashCode ^
      titleEvent.hashCode ^
      descriptionEvent.hashCode;

  @override
  String toString() {
    return 'Ticket{id: $id, eventId: $eventId, userId: $userId, userPhone: $userPhone, userName: $userName, userTicketNumber: $userTicketNumber, dataEvent: $dataEvent, address: $address, titleEvent: $titleEvent, descriptionEvent: $descriptionEvent}';
  }
}
