import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './addmachinepage.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'mainpage.dart';

class QRPage extends StatefulWidget {
  var _details,_username,_password;

  QRPage(this._details);

  State<StatefulWidget> createState() {
    return QRPageState(_details,this._username,this._password);
  }
}

class QRPageState extends State<QRPage> {
  var _details,_username,_password;
  var responsee;

  @override
  void initState() {
    responsee = _postData();
    super.initState();
  }

  QRPageState(this._details,this._username,this._password);

  String obscureText(String value) {
    String last = value.substring(value.length - 3);
    String first = value.substring(0, 3);
    String fin = first + "***" + last;
    return fin;
  }

  Future _postData() async {
    var data = json.encode(_details);
    var _response = await http.post("https://formfield.azurewebsites.net/putmachine",
        body: data,headers: {"Content-Type": "application/json"});
    print(_response.body);
    return _response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 18, 70, 255),
      appBar: AppBar(
        centerTitle: true,
        title: Text("QR Code"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: FutureBuilder(
          future: responsee,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var qrData = snapshot.data.body;
              var qrCode = qrData.toString().substring(8);
              qrData = qrCode.replaceFirst("\"}", "");
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                color: Colors.black.withOpacity(0.45),
                                blurRadius: 30.0)
                          ]),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 20.0, top: 20),
                                        child: Text(
                                          obscureText(qrData),
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 4),
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(top: 14.0),
                                        child: Icon(
                                          Icons.linked_camera,
                                          size: 50,
                                        ),
                                      ),
                                      flex: 2),
                                ],
                              )),
                          Expanded(
                              flex: 8,
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: QrImage(
                                  data: qrData,
                                ),
                              )),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: 600,
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(250, 18, 70, 255),
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        color: Colors.black.withOpacity(0.45),
                                        blurRadius: 30.0)
                                  ]),
                              child: InkWell(
                                child: Center(
                                  child: Text("Continue to Home",
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white
                                      )),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return HomePage(_username,_password);
                                  }));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Bottom Text
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(28.0),
                      decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        color: Colors.black.withOpacity(0.45),
                                        blurRadius: 30.0)
                                  ]),
                      child: Center(
                        child: Text(
                          "Export as PNG",
                          style: TextStyle(fontSize: 27.0, color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
