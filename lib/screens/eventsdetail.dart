import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepeve/screens/checkin.dart';
import 'package:nepeve/util/lineup.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsDetail extends StatefulWidget {
  final assetPath,
      eventprice,
      eventname,
      eventaddress,
      eventdescription,
      eventtime,
      eventlineup,
      id;

  EventsDetail(
      {this.assetPath,
      this.eventprice,
      this.eventname,
      this.eventaddress,
      this.eventdescription,
      this.eventtime,
      this.eventlineup,
      this.id});

  @override
  _EventsDetailState createState() => _EventsDetailState();
}

class _EventsDetailState extends State<EventsDetail> {
  bool _isFavorited = true;
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  void launchMap() async {
    String query = Uri.encodeComponent(widget.eventaddress);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map, color: Colors.orange),
            onPressed: launchMap,
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(widget.eventname,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
        ),
        SizedBox(height: 15.0),
        Hero(
            tag: widget.assetPath,
            child: Image.network(widget.assetPath,
                height: 250.0, width: 100.0, fit: BoxFit.cover)),
        Row(children: <Widget>[
          SizedBox(width: 25.0),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'LineUp',
                    style: TextStyle(
                        color: Color(0xFFCC8053),
                        fontFamily: 'Varela',
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LineupPage(
                                  lineup: widget.eventlineup,
                                )));
                      }),
              ],
            ),
          ),
          SizedBox(width: 80.0),
          Text("Rs.${widget.eventprice}",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
          SizedBox(width: 80.0),
          IconButton(
            icon: (_isFavorited
                ? Icon(Icons.favorite_border)
                : Icon(Icons.favorite)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ]),
        SizedBox(height: 10.0),
        Center(
          child: Text(widget.eventaddress,
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(
            DateFormat("dd-MMMM-yyyy").format(DateTime.parse(widget.eventtime)),
            style: TextStyle(
                color: Color(0xFFF17532), fontFamily: 'Varela', fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(widget.eventdescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 40.0),
        Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                child: RaisedButton(
                    child: Text(
                      'Book your ticket',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CheckinPage(
                              price: widget.eventprice,
                              name: widget.eventname,
                              date: widget.eventtime,
                              location: widget.eventaddress,
                              id: widget.id)));
                    },
                    splashColor: Colors.grey,
                    color: Color(0xFFF17532),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)))))
      ]),
    );
  }
}
