// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nepeve/support/payment.dart';
// import 'package:uuid/uuid.dart';

class CheckinPage extends StatefulWidget {
  final price, name, date, location, id;

  CheckinPage({this.price, this.name, this.date, this.location, this.id});

  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  // var uuid = Uuid();
  final GlobalKey<FormBuilderState> _checkoutFormKey =
      GlobalKey<FormBuilderState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ticketController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
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
        body: FormBuilder(
          key: _checkoutFormKey,
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Icon(
                  Icons.headset_mic,
                  size: 80.0,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.name.toString(),
              style: TextStyle(fontSize: 20.0, fontFamily: "varela"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(
                        fillColor: Colors.black.withOpacity(0.6),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(8.0),
                          ),
                        ),
                        hintText: 'Name',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 16.0)),
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    controller: nameController,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: FormBuilderTextField(
                    attribute: "Email",
                    decoration: InputDecoration(
                        fillColor: Colors.black.withOpacity(0.6),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(8.0),
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 16.0)),
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ],
                    controller: emailController,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: FormBuilderTextField(
                    attribute: "ticket",
                    controller: ticketController,
                    decoration: InputDecoration(hintText: "No.of Tickets"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CustomRangeTextInputFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validators: [
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(70),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RaisedButton(
                    child: Text(
                      'Proceed',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_checkoutFormKey.currentState.saveAndValidate()) {
                        //   await Firestore.instance.collection('tickets').add({
                        //     "ticketid": uuid.v4(),
                        //   });

                        await Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => new EsewaPayment(
                                eprice: int.parse(widget.price),
                                rprice: int.parse(ticketController.text),
                                email: emailController.text,
                                client: nameController.text,
                                name: widget.name,
                                date: widget.date,
                                location: widget.location,
                                id: widget.id)));
                      }
                    },
                    splashColor: Colors.grey,
                    color: Color(0xFFF17532),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                SizedBox(
                  height: 2.0,
                ),
                RaisedButton(
                    child: Text("Reset"),
                    onPressed: () {
                      _checkoutFormKey.currentState.reset();
                    },
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 20
        ? TextEditingValue().copyWith(text: '20')
        : newValue;
  }
}
