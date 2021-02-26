import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  final email, password;
  ProfilePage({this.email, this.password});
  Stream getData() async* {
    // ignore: unused_local_variable
    User user = FirebaseAuth.instance.currentUser;
    yield* FirebaseFirestore.instance
        .collection('users')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(10.0)),
      Center(
          child: Text(
        "User Info",
        style: TextStyle(
            color: Color(0xFFCC8053),
            fontFamily: 'Varela',
            fontSize: 22.5,
            fontWeight: FontWeight.bold),
      )),
      StreamBuilder(
          stream: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildResultCard(context, snapshot.data.documents[index]),
              ),
            );
          }),
    ]));
  }

  Widget _buildResultCard(BuildContext context, DocumentSnapshot documents) {
    return Padding(
      padding: const EdgeInsets.only(top: 55.0, left: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Name : ${documents['displayName']}",
            style: TextStyle(fontSize: 25.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Email : ${documents['email']}",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: <Widget>[
              Text(
                "Created : ",
                style: TextStyle(fontSize: 25.0),
              ),
              Text(
                DateFormat("dd-MMMM-yyyy").format(DateTime.parse(
                  documents['created'].toDate().toString(),
                )),
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
            splashColor: Colors.red,
            child: const Text('Delete Account',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Varela',
                )),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
