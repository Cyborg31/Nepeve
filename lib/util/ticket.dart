import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class TicketPage extends StatefulWidget {
  final name, email, people, date, location;

  TicketPage({this.name, this.email, this.people, this.date, this.location});
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  GlobalKey _globalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    _requestPermission();
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();

    _toastInfo(info);
  }

  // ignore: missing_return
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result =
        await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print(result);
    _toastInfo(result.toString());
  }

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RepaintBoundary(
        key: _globalKey,
        child: GestureDetector(
          onLongPress: () {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(130.0, 300.0, 300.0, 0.0),
              items: <PopupMenuEntry>[
                PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.save), onPressed: _capturePng),
                      Text("save"),
                    ],
                  ),
                )
              ],
            );
          },
          child: Center(
            child: FlutterTicketWidget(
              width: 350.0,
              height: 500.0,
              isCornerRounded: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          height: 25.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(width: 1.0, color: Colors.green),
                          ),
                          child: Center(
                            child: Text(
                              'NepEve',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(widget.name),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Event Ticket',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Column(
                        children: <Widget>[
                          ticketDetailsWidget(
                            'Name',
                            widget.name,
                            'Date',
                            DateFormat("dd-MMMM-yyyy")
                                .format(DateTime.parse(widget.date)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, right: 55.0),
                            child: ticketDetailsWidget(
                                'No. of people',
                                widget.people.toString(),
                                'Location',
                                widget.location),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          QrImage(
                            data: uuid.v4(),
                            version: QrVersions.auto,
                            size: 180,
                            errorStateBuilder: (cxt, err) {
                              return Container(
                                child: Center(
                                  child: Text(
                                    'Error',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(color: Colors.red),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
