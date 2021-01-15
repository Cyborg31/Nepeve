import 'package:flutter/material.dart';
import 'package:nepeve/widgets/scan.dart';
import 'auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nepeve/widgets/theme.dart';
import 'package:provider/provider.dart';
import 'package:nepeve/screens/events.dart';
import 'package:nepeve/screens/news.dart';
import 'package:nepeve/screens/Profile.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchState = false;
  int _selectedPage = 0;
  final _pageOptions = [
    EventsPage(),
    NewsPage(),
    ProfilePage(),
  ];

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nepevents',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.dashboard, color: Colors.orange),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ScanPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              padding: EdgeInsets.only(top: 50.0),
              children: <Widget>[
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => SwitchListTile(
                    title: Text("Dark Mode"),
                    onChanged: (val) {
                      notifier.toggleTheme();
                    },
                    value: notifier.darkTheme,
                  ),
                ),
                ListTile(
                  title: Text('Favorites'),
                  leading: Icon(Icons.favorite),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite');
                  },
                ),
                ListTile(
                  title: Text('Notifications'),
                  leading: Icon(Icons.notifications),
                  onTap: () {
                    Navigator.pushNamed(context, '/notification');
                  },
                ),
                ListTile(
                    title: Text('Past Events'),
                    leading: Icon(Icons.music_note),
                    onTap: () {
                      Navigator.pushNamed(context, '/pastevents');
                    }),
                ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.exit_to_app),
                    onTap: _signOut),
              ],
            )),
          ],
        ),
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.apps,
                size: 30,
              ),
              label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(
                Feather.getIconData("user"),
                size: 30,
              ),
              label: 'User'),
        ],
      ),
    );
  }
}
