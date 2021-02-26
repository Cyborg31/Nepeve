import 'package:flutter/material.dart';

class LineupPage extends StatelessWidget {
  final lineup;

  LineupPage({this.lineup});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Theme.of(context),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Lineup'),
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Center(
                  child: Text(
                lineup.replaceAll(",", "\n"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFCC8053),
                    fontFamily: 'Varela',
                    fontSize: 22.5,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ));
  }
}
