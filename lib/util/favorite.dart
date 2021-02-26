import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Favorites> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Theme.of(context),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Favorites'),
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Container(
                child: Column(children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text("FAVORITES"),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _favorites.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text("hello"),
                      );
                    }),
              ),
            ]))));
  }
}
