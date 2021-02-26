import 'package:flutter/material.dart';
import 'package:nepeve/screens/eventslist.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 7.0, right: 7.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text('Categories',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xFFC88D67),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Concerts',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Acoustic',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('DJ',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                )
              ]),
          Container(
              height: MediaQuery.of(context).size.height * 0.63,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                EventsList(),
                EventsList(),
                EventsList(),
              ]))
        ],
      ),
    );
  }
}
