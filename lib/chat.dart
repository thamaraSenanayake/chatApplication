import 'package:chat/chatModel.dart';
import 'package:chat/const.dart';
import 'package:chat/firebaseService.dart';
import 'package:flutter/material.dart';
import 'package:chat/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  Color sendButtonColor = Colors.blueGrey;
  List<ChatMessage> _message = <ChatMessage>[];
  final TextEditingController _textEditingController = TextEditingController(); 
  String user,sender;
  //FirebaseService _firebaseService = FirebaseService(ChatDetails.userName,ChatDetails.senderName);

  ChatScreenState(){
    print("start");
    //_firebaseService.appStats.listen(_onStatsUpdateted);
  }
  @override
  void initState() {
    user = ChatDetails.userName;
    sender = ChatDetails.senderName;
    //print(user+""+sender);
    _getData();
    super.initState();
    
  }

  // void _onStatsUpdateted(ChatModel chatModel){
  //   // if (chatModel != null) {
  //   //   print("---------------------------------------------------------");
  //   //   print(chatModel.msg);
  //   // }
  //   // print("loading");
  // }

  void _handleSumbitted(String text){

    ChatMessage message = ChatMessage(msg:_textEditingController.text);    
    var timeStamp = (DateTime.now());
    Firestore.instance.collection('message').document(_getChatName(sender,user))
                        //.document(_getChatName(sender,user)).updateData({"'"+timeStamp.millisecondsSinceEpoch.toString()+"'":{'reciver':sender,'sender':user ,'msg':text,'time': timeStamp.toString()}});
                          .collection("msgList")
                            .document(timeStamp.millisecondsSinceEpoch.toString())
                              .setData({ 
                                'reciver':sender,
                                'sender':user ,
                                'msg':text,
                                'time': timeStamp.toString() 
                              });

    setState(() {
      _message.insert(0, message);
    });
    
    _textEditingController.clear();    
  }


  //get unique caht head
  _getChatName(String firstName,String secondName){
    List<String> chatName = [firstName, secondName];
    chatName.sort((a, b) => a.length.compareTo(b.length));
    return chatName[0]+"_"+chatName[1];
  }

  //msg sending button color change according to the msg avalability
  _buttonColorChange(String text){
    if(text.length > 0){
      setState(() {
        sendButtonColor = Colors.blue;
      });
    }
    else{
      setState(() {
        sendButtonColor = Colors.blueGrey;
      });
    }
  }

  _getData() {
    Firestore.instance.collection('message')
          .document(_getChatName(sender,user))
          .collection("msgList")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
            snapshot.documents.forEach((f) {
              //print('${f.data}');
              ChatMessage message = ChatMessage(msg:f.data['msg']);    
              setState(() {
                _message.insert(0, message);
              });
            });
          });

    // Firestore.instance.collection('message')
    //       .document(_getChatName(sender,user)).get()
    //       .then((DocumentSnapshot ds) {
    //         print("*****************"+ds.data.toString());
    //       });

  }


  
    
  Widget _textComposerWeight(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: "Send message",
              ),
              controller: _textEditingController,
              onSubmitted: _handleSumbitted,
              onChanged: _buttonColorChange,
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: sendButtonColor,
              onPressed: ()=> _handleSumbitted(_textEditingController.text),
            ),

          ),

         StreamBuilder(
          //  .document(_getChatName(sender,user)).get()
          // .then((DocumentSnapshot ds) {
          //   print("*****************"+ds.data.toString());
          // });
          stream:Firestore.instance.collection('message').document(_getChatName(sender,user)).collection("msgList").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError){
              print("error");
              return  Text('Error: ${snapshot.error}');
            }  
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: 
                print("waiting");
                return  Text('waiting');
              default:
                // return new ListView(
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    print(document);
                    //print("document");
                    return Text(document.toString());
                  });
                return Text("null");
               // );
            }
          },
         ) 
        ],
      ),
    );
  }
    
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(5),
            reverse: true,
            itemBuilder: (_,int index)=>_message[index],
            itemCount: _message.length,
          ),
        ),

        Divider(
          height: 1.0,
        ),

        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _textComposerWeight() ,
        ),
      ],
    );
    //return _textComposerWeight();
  }

}


// class BookList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('books').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError)
//           return new Text('Error: ${snapshot.error}');
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting: return new Text('Loading...');
//           default:
//             return new ListView(
//               children: snapshot.data.documents.map((DocumentSnapshot document) {
//                 return new ListTile(
//                   title: new Text(document['title']),
//                   subtitle: new Text(document['author']),
//                 );
//               }).toList(),
//             );
//         }
//       },
//     );
//   }
// }