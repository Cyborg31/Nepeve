import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nepeve/util/message.dart';

class NotificationsPage extends StatefulWidget {
  final id, reference;
  NotificationsPage({this.id, this.reference});
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "navigator");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onmessage: $message");
      final notification = message['data'];
      setState(() {
        messages.add(Message(
            title: '${notification['title']}',
            image: '${notification['image']}',
            body: '${notification['body']}'));
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsPage()));
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");

      final notification = message['data'];
      setState(() {
        messages.add(Message(
            title: '${notification['title']}',
            image: '${notification['image']}',
            body: '${notification['body']}'));
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsPage()));
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsPage()));
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: Theme.of(context),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Notifications'),
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildMessage(context, messages[index]);
                    }))));
  }

  Widget buildMessage(BuildContext context, Message message) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 1.50, left: 10.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Card(
          child: Column(
            children: <Widget>[
              Image.network(
                message.image,
                fit: BoxFit.fitWidth,
                height: 200.0,
                width: 280.0,
              ),
              // Text(
              //   message.title,
              //   style: TextStyle(
              //     fontFamily: "Varela",
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Text(
                message.body,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Varela",
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
