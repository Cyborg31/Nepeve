import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nepeve/util/card.dart';

class Favorites extends StatelessWidget {
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
            "Favorites",
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
                  .where("favorite", isEqualTo: true)
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
                        buildCard(context, snapshot.data.documents[index]));
              }),
        ]),
      ),
    );
  }
}
