import 'dart:async';

import 'package:chat/chatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  String sender,reciver;
  final StreamController<ChatModel> _statsController = StreamController<ChatModel>();

  FirebaseService(String sender, String reciver){
    print(sender+''+reciver);
    Firestore.instance.collection('message')
          .document(_getChatName(sender,reciver))
          .snapshots()
          .listen(_statsUpdate);   
  }  

  Stream<ChatModel> get appStats => _statsController.stream;


  //get unique caht head
  _getChatName(String firstName,String secondName){
    List<String> chatName = [firstName, secondName];
    chatName.sort((a, b) => a.length.compareTo(b.length));
    return chatName[0]+"_"+chatName[1];
  }

  void _statsUpdate(DocumentSnapshot snapshot) {
    _statsController.add(ChatModel.fromSnapshot(snapshot));
  }

}