//ONLY LOCAL DB
class Ticket {
  final int? id;
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

  const Ticket(
      {this.id,
      this.eventId,
      this.userKey,
      this.userPhone,
      this.userName,
      this.userTicketNumber,
      this.image,
      this.phoneContact,
      this.address,
      this.date,
      this.title,
      this.description,
      this.userKeyOfEvent});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
        id: map['id'] as int,
        eventId: map['event_id'] as int,
        userKey: map['user_key'] as int,
        userPhone: map['user_phone'] as String,
        userName: map['user_name'] as String,
        userTicketNumber: map['user_ticket_number'] as String,
        image: map['image'] as String,
        phoneContact: map['phone_contact'] as String,
        address: map['address'] as String,
        date: map['date'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        userKeyOfEvent: map['user_key_of_event'] as int);
  }
}
