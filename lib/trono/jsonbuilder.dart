import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_to_form/json_to_form.dart';
import 'models/template.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class JsonBuilder extends StatefulWidget{
  var form;
  String uid;
  bool isResponse ;
  String uname;
  JsonBuilder(this.form,{this.isResponse=false,this.uid=" ",this.uname=" "});


  @override
  JsonBuilderState createState() => new JsonBuilderState();

}

class JsonBuilderState extends State<JsonBuilder>{
  dynamic response;

  Widget giveButton(){
    if(widget.isResponse){
      return  Container(width: MediaQuery.of(context).size.width,
        child: new RaisedButton(
            child: new Text('Send',style: TextStyle(color: Color.fromARGB(250, 18, 70, 255)),),color: Colors.yellow,
            onPressed: ()async {

              var sendRecord = {
                "s_no": "",
                "dos": "2017-01-21",
                "wid_s": "1",
                "doc":"",
                "wid_c": "",
                "record": jsonEncode(response),
                "status":"true",
                "uid":widget.uid
              };
              print(widget.uid);
              var respons = await http.post("https://formfield.azurewebsites.net/putrecord",body: json.encode(sendRecord),headers: {"Content-Type": "application/json"} );
              print(respons.body);
              Navigator.pop(context);
             print(this.response);
//              print(json.encode());
            }),
      );
    }else{
      return  Container(width: MediaQuery.of(context).size.width,
        child: new RaisedButton(
            child: new Text('go back',style: TextStyle(color: Color.fromARGB(250, 18, 70, 255)),),color: Colors.yellow,
            onPressed: () {
            Navigator.pop(context);
            }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(backgroundColor: Color.fromARGB(250, 18, 70, 255),),
      body: new SingleChildScrollView(
        child: new Container(
// Center is a layout widget. It takes a single child and positions it
// in the middle of the parent.
          child: new Column(children: <Widget>[
            new CoreForm(
              form: jsonEncode(widget.form),
              onChanged: (dynamic response) {
                this.response = response;

              },
            ),
            giveButton()

          ]),
        ),
      ),
    );
  }

}