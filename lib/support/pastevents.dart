import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastEventsView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
              child: Text(
            "Past Events",
            style: TextStyle(
                color: Color(0xFFCC8053),
                fontFamily: 'Varela',
                fontSize: 22.5,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('events')
                  .where("date", isLessThan: DateTime.now())
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildResultCard(
                            context, snapshot.data.documents[index]));
              }),
        ]),
      ),
    );
  }

  Widget buildResultCard(BuildContext context, DocumentSnapshot events) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0, bottom: 1.50, left: 2.0, right: 2.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(children: [
            Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                )),
            Hero(
              tag: events["url"],
              child: Container(
                height: 130.0,
                width: 100.0,
                child: Image.network(events["url"], fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 0.5),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 4.0, left: 4.0),
                child: Text(
                  events['name'],
                  style: TextStyle(
                      color: Color(0xFFCC8053),
                      fontFamily: 'Varela',
                      fontSize: 20.5),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Expanded(
              child: Text(
                DateFormat("dd-MMM")
                    .format(DateTime.parse(events["date"].toDate().toString())),
                style: TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
          ])),
    );
  }
}
