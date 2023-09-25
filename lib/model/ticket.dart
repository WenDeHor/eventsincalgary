class Ticket {
  final int? id;
  final String? userPhone;
  final String? userName;
  final String? userTicketNumber;
  final String? dataEvent;
  final String? titleEvent;
  final String? descriptionEvent;


  Ticket(this.id, this.userPhone, this.userName, this.userTicketNumber,  this.dataEvent, this.titleEvent, this.descriptionEvent);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userPhone': userPhone,
      'userName':userName,
      'userTicketNumber': userTicketNumber,
      'dataEvent': dataEvent,
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
          userPhone == other.userPhone &&
          userName == other.userName &&
          userTicketNumber == other.userTicketNumber &&
          dataEvent == other.dataEvent &&
          titleEvent == other.titleEvent &&
          descriptionEvent == other.descriptionEvent;

  @override
  int get hashCode =>
      id.hashCode ^
      userPhone.hashCode ^
      userName.hashCode ^
      userTicketNumber.hashCode ^
      dataEvent.hashCode ^
      titleEvent.hashCode ^
      descriptionEvent.hashCode;

  @override
  String toString() {
    return 'Ticket{id: $id, userPhone: $userPhone, userName: $userName, userTicketNumber: $userTicketNumber, dataEvent: $dataEvent, titleEvent: $titleEvent, descriptionEvent: $descriptionEvent}';
  }
}