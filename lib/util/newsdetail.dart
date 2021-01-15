import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class NewsDetail extends StatefulWidget {
  final image, date, description, lineup, video;
  NewsDetail(
      {this.image, this.date, this.description, this.lineup, this.video});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context),
      home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView(children: <Widget>[
            Hero(
                tag: widget.image,
                child: Image.network(widget.image, fit: BoxFit.cover)),
            SizedBox(height: 20),
            Text(
              DateFormat("dd-MMMM-yyyy")
                  .format(DateTime.parse(widget.date.toDate().toString())),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 15.0),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: widget.description,
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 20.5,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            SizedBox(
              height: 10.0,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Lineup : " + "\n" "${widget.lineup.replaceAll(",", "\n")}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: (Colors.blueGrey),
                  fontFamily: 'Varela',
                  fontSize: 20.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            )
          ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
