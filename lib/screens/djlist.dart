import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nepeve/support/details.dart';
import 'package:nepeve/util/card.dart';

class DjList extends StatefulWidget {
  @override
  DjListState createState() => DjListState();
}

class DjListState extends State<DjList> {
  DateTime now = new DateTime.now();

  TextEditingController _searchController = TextEditingController();

  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = geteventssnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var eventSnapshot in _allResults) {
        var title = Event.fromSnapshot(eventSnapshot).name.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(eventSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  geteventssnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('events')
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .where('category', isEqualTo: 'dj')
        .get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "Complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(shrinkWrap: true, children: <Widget>[
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextField(
          controller: _searchController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () => {
                  _searchController.clear(),
                },
                icon: Icon(Icons.clear),
              ),
              border: InputBorder.none,
              hintText: 'Search...'),
        ),
      ),
      SizedBox(height: 10.0),
      GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _resultsList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildCard(context, _resultsList[index])),
    ]));
  }
}
