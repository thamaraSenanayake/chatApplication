import 'package:chat/const.dart';
import 'package:flutter/material.dart';
import 'package:chat/chat.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName= '',senderName= '';

  @override
  void initState() {
    setState(() {
      userName= '';
    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    final _email = TextEditingController();
    final _sender = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Chat"),
      // ),

      body:userName!=''?ChatScreen():
      ListView(
        children: <Widget>[

        Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),

            Text(
              "Chat",
              style: TextStyle(fontSize: 80.0,fontStyle:FontStyle.italic,fontWeight: FontWeight.w800,color: Colors.blue),
            ),

            SizedBox(
              height: 20.0,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                              
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  ),

                  

                  labelText: "Enter Email",
                  
                  //fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(
                    ),
                  ),  
                  suffixIcon: Icon(Icons.email),
                              //fillColor: Colors.green
                ),

                controller: _email,
                
                validator: (val) {
                  if(val.length==0) {
                    return "Email cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black
                ),
              ),
            ),

            SizedBox(
              height: 20.0,
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  ),

                  labelText: "Enter Email",
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(
                    ),
                  ),  
                  suffixIcon: Icon(Icons.email),
                              //fillColor: Colors.green
                ),
                controller: _sender,
                
                validator: (val) {
                  if(val.length==0) {
                    return "Email cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black
                ),
              ),
            ),

            SizedBox(
              height: 20.0,
            ),

            ButtonTheme(
              minWidth: 200.0,
               child: RaisedButton(
                onPressed: () {
                  setState(() {
                    userName = _email.text;
                    ChatDetails.userName = userName;
                    senderName = _sender.text;
                    ChatDetails.senderName = senderName;
                  });

                  //print(userName+""+senderName);
                },
                textColor: Colors.black,
                              
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: <Color>[
                    //     Color(0xFF0D47A1),
                    //     Color(0xFF1976D2),
                    //     Color(0xFF42A5F5),
                    //   ],
                    // ),
                    color: Colors.blue
                    
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
            ),

          ],
          
        ),
        ],
      ),
    );
  }
}