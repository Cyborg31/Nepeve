import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nepeve/util/newsdetail.dart';

class NewsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Center(
            child: Text(
          "News",
          style: TextStyle(
              color: Color(0xFFCC8053),
              fontFamily: 'Varela',
              fontSize: 15.5,
              fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 10.0,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('events')
                .where("date", isLessThan: DateTime.now())
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Expanded(
                child: new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildResultCard(
                            context, snapshot.data.documents[index])),
              );
            }),
      ]),
    );
  }

  Widget buildResultCard(BuildContext context, DocumentSnapshot events) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(42),
              child: Image.asset(
                'assets/band2.png',
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'hey',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'hey',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'hey',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'hey',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'To read the whole article,',
                    style: TextStyle(
//                                  color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => NewsDetail()),
                    ),
                    child: Text(
                      'Go to the original page.',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
