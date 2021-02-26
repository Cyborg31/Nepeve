import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepeve/util/ticket.dart';

class EsewaPayment extends StatefulWidget {
  final eprice, rprice, email, name, date, location, id, client;

  EsewaPayment(
      {this.eprice,
      this.rprice,
      this.email,
      this.name,
      this.date,
      this.location,
      this.id,
      this.client});
  @override
  EsewaPaymentState createState() => EsewaPaymentState();
}

class EsewaPaymentState extends State<EsewaPayment> {
  // ignore: unused_field
  ESewaConfiguration _configuration;
  ESewaPnp _eSewaPnp;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _configuration = ESewaConfiguration(
      clientID: 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
      secretKey: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
      environment: ESewaConfiguration.ENVIRONMENT_TEST,
    );
    _eSewaPnp = ESewaPnp(configuration: _configuration);
  }

  @override
  Widget build(BuildContext context) {
    int total = widget.eprice * widget.rprice;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Payment"),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(
            height: 180.0,
          ),
          Center(
            child: Text(
              "Your Total Amount is Rs : ${total.toString()}",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "valera"),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          RaisedButton(
              child: Text("Pay With E-sewa"),
              onPressed: () {
                pay();
              },
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
        ]),
      ),
    );
  }

  Future<void> pay() async {
    ESewaPayment eSewaPayment = ESewaPayment(
      amount: widget.eprice * widget.rprice,
      productName: widget.name,
      productID: widget.id,
      callBackURL: "https://example.com/",
    );

    final res = await _eSewaPnp.initPayment(payment: eSewaPayment);
    print(res.toString());

    res.fold((failure) {
      _scaffoldKey.currentState
          .showSnackBar(_buildSnackBar(Colors.red, failure.message));
    }, (result) async {
      _scaffoldKey.currentState.showSnackBar(
          _buildSnackBar(Color.fromRGBO(65, 161, 36, 1), result.message));

      await FirebaseFirestore.instance.collection('tickets').add({
        "client": widget.client,
        "event": widget.name,
        "email": widget.email,
        "no.of tickets": widget.rprice,
        'bookedDate': DateFormat("yyyy-MM-dd").format(DateTime.now()),
      });

      DocumentReference ref =
          FirebaseFirestore.instance.doc("events/${widget.id}");
      ref.update({"total tickets sold": FieldValue.increment(widget.rprice)});

      await Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new TicketPage(
                name: widget.name,
                email: widget.email,
                people: widget.rprice,
                date: widget.date,
                location: widget.location,
              )));
    });
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
  }
}
