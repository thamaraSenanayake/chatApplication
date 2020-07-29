import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  
  String msg;
  String reciver;
  String sender;
  String time;
  ChatModel({this.msg,this.reciver,this.sender,this.time});
  
  ChatModel.fromSnapshot(DocumentSnapshot snapShot) :
   msg = snapShot['appCount'] ?? 0,
   reciver = snapShot['userCount'] ?? 0,
   time = snapShot['userCount'] ?? 0,
   sender = snapShot['errorCount'] ?? 0;

   
}
