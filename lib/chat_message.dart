import 'package:flutter/material.dart';


class ChatMessage extends StatefulWidget {
  String msg;
  String reciver;
  String sender;
  String time;
  ChatMessage({this.msg,this.reciver,this.sender,this.time});
  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:50.0,left: 0.0),
      child: Card(
        color:Colors.white ,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Container(
                margin: EdgeInsets.only(right:16.0),
                child: CircleAvatar(
                  child: Text("T"),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Thilak",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Container(
                    margin: EdgeInsets.only(top:5.0,bottom: 10.0),
                    child: Text(widget.msg),
                    //color:Colors.white ,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}