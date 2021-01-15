import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String name;
  DateTime createdAt;
  DateTime date;
  String description;
  String lineup;
  String url;
  String location;
  int price;

  Event(this.name, this.createdAt, this.date, this.description, this.lineup,
      this.location, this.price, this.url);

// creating a Trip object from a firebase snapshot
  Event.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        createdAt = snapshot['createdAt'].toDate(),
        date = snapshot['date'].toDate(),
        description = snapshot['description'],
        lineup = snapshot['lineup'],
        location = snapshot['location'],
        url = snapshot['url'],
        price = snapshot['price'];
}
