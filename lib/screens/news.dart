import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nepeve/util/newsdetail.dart';

class NewsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('news')
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

  Widget buildResultCard(BuildContext context, DocumentSnapshot news) {
    return Card(
      child: Padding(
        padding:
            EdgeInsets.only(top: 4.0, bottom: 1.50, left: 15.0, right: 15.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewsDetail(
                    image: news['image'],
                    date: news['date'],
                    description: news['longdescription'],
                    lineup: news['lineup'],
                    video: news['video'])));
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                      )),
                  Hero(
                    tag: news["image"],
                    child: Container(
                      child: Image.network(
                        news['image'],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      news['title'],
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
