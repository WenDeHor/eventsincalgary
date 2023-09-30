class Ticket {
  final int? id;
  final int? eventId; //id from FB
  final int? userKey;
  final String? userPhone;
  final String? userName;
  final String? userTicketNumber;
  final String? dataEvent;
  final String? address;
  final String? titleEvent;
  final String? descriptionEvent;

  Ticket(this.id, this.eventId, this.userKey, this.userPhone, this.userName, this.userTicketNumber, this.dataEvent, this.address, this.titleEvent,
      this.descriptionEvent);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'userKey': userKey,
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
          userKey == other.userKey &&
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
      userKey.hashCode ^
      userPhone.hashCode ^
      userName.hashCode ^
      userTicketNumber.hashCode ^
      dataEvent.hashCode ^
      address.hashCode ^
      titleEvent.hashCode ^
      descriptionEvent.hashCode;

  @override
  String toString() {
    return 'Ticket{id: $id, eventId: $eventId, userKey: $userKey, userPhone: $userPhone, userName: $userName, userTicketNumber: $userTicketNumber, dataEvent: $dataEvent, address: $address, titleEvent: $titleEvent, descriptionEvent: $descriptionEvent}';
  }
}
