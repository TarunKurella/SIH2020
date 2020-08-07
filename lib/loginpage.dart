import 'package:flutter/material.dart';
import './mainpage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String _username;
  String _password;
  bool user = false;
  bool pass = false;

  void buttonValue() {
    bool a = user && pass;
    if (a == true) {
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget loginpage = Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(
              child: Text(
                "Login Page",
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          ),
          Container(
            height: 200,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              height: 250,
              width: 350,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 208, 235, 236),
                  borderRadius: BorderRadius.circular(20.0),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 0.6),
                        color: Colors.grey,
                        blurRadius: 25.0)
                  ]),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        "UserName",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 25.0, top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter Username/Email",
                      ),
                      onChanged: (inputGiven) {
                        setState(() {
                          if (inputGiven != null ) {
                            user = true;
                            _username = inputGiven;
                            debugPrint(_username);
                          } else {
                            user = false;
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        "Password",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 25.0, top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter password",
                      ),
                      obscureText: true,
                      autofocus: false,
                      onChanged: (inputGiven) {
                        setState(() {
                          if (inputGiven != null ) {
                            pass = true;
                            _password = inputGiven;
                            debugPrint(_password);
                          } else {
                            pass = false;
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 208, 235, 236),
                  borderRadius: BorderRadius.circular(100.0),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 0.6),
                        color: Colors.grey,
                        blurRadius: 25.0)
                  ]),
              height: 50,
              width: 350,
              child: RaisedButton(
                child: Text(
                  "Login/SignUp",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Color(0xFf00003f),
                onPressed: () {
                  if (user && pass) {
                    Navigator.push(context,
                        MaterialPageRoute(
                          settings: RouteSettings(name: "LoginPage"),
                          builder: (context) {
                      return HomePage(_username, _password);
                    }));
                  } else {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Alert'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  "Haven't Entered Valid \nUsername/password",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Okay"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );

    return loginpage;
  }
}
