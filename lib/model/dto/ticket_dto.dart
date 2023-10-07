class TicketDto {
  final int? eventId; //id from FB
  //USER
  final int? userKey;
  final String? userPhone;
  final String? userName;

  //EVENT
  final String? userTicketNumber; //TODO currently no generate
  final String? image;
  final String? phoneContact;
  final String? address;
  final String? date;
  final String? title;
  final String? description;
  final int? userKeyOfEvent;

  const TicketDto(
      {required this.eventId,
      required this.userKey,
      required this.userPhone,
      required this.userName,
      required this.userTicketNumber,
      required this.image,
      required this.phoneContact,
      required this.address,
      required this.date,
      required this.title,
      required this.description,
      required this.userKeyOfEvent});

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventId,
      'user_key': userKey,
      'user_phone': userPhone,
      'user_name': userName,
      'user_ticket_number': userTicketNumber,
      'image': image,
      'phone_contact': phoneContact,
      'address': address,
      'date': date,
      'title': title,
      'description': description,
      'user_key_of_event': userKeyOfEvent,
    };
  }
}
