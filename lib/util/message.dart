import 'package:flutter/material.dart';

@immutable
class Message {
  final String title;
  final String body;
  final String image;

  const Message(
      {@required this.title, @required this.body, @required this.image});
}
