import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formkey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _displayName;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password, _displayName);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(e.message),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }

  void moveToRegister() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  Widget googlelogin() {
    return GoogleSignInButton(
      onPressed: () {
        Auth().signInWithGoogle().whenComplete(() {
          Navigator.pushNamed(context, '/');
        });
      },
      darkMode: true,
      splashColor: Colors.white,
      borderRadius: 10.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.overlay),
            image: AssetImage('assets/band2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: new ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 120.0),
              child: Center(
                child: Icon(
                  Icons.headset_mic,
                  color: Colors.white,
                  size: 80.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Nepevents",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: new Form(
                key: formkey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() + buildSubmitButtons(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Email',
          ),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
        Divider(
          height: 24.0,
        ),
        new TextFormField(
          obscureText: true,
          decoration: new InputDecoration(labelText: 'Password'),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value,
        ),
        Divider(
          height: 24.0,
        ),
      ];
    } else {
      return [
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Name',
          ),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (value) => _displayName = value,
        ),
        Divider(
          height: 24.0,
        ),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Email',
          ),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
        Divider(
          height: 24.0,
        ),
        new TextFormField(
          obscureText: true,
          decoration: new InputDecoration(labelText: 'Password'),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value,
        ),
        Divider(
          height: 24.0,
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: new Text(' Login',
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        Divider(
          height: 15.0,
        ),
        new FlatButton(
          child: new Text('Create an account',
              style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(child: googlelogin()),
      ];
    } else {
      return [
        new RaisedButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: new Text(' Sign Up',
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        Divider(
          height: 15.0,
        ),
        new FlatButton(
          child: new Text('Have an account? Login',
              style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(child: googlelogin()),
      ];
    }
  }
}
