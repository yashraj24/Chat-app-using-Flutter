import 'package:WeChat/helper/constants.dart';
import 'package:WeChat/services/database.dart';
import 'package:WeChat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatsMessageStream;

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatsMessageStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context,index){
            return MessageTile(snapshot.data.documents[index].data["message"],
            snapshot.data.documents[index].data["sendby"] == Constants.myName);
          }) : Container();
      },
    );
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
      "message" : messageController.text,
      "sendby" : Constants.myName,
      "time" :DateTime.now().millisecondsSinceEpoch,
    };
    databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    messageController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatsMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 1.0,
                child: Container(
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(                  
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                              color: Colors.white,
                            ),
                          decoration: InputDecoration(
                            hintText: "Message",                            
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: InputBorder.none
                          ),
                        )),
                      GestureDetector(
                        onTap: (){
                          sendMessage();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]
                            ),
                            borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/images/send.png")
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe ) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0: 24, right: isSendByMe ? 24 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isSendByMe ? Colors.redAccent : Colors.grey,
          borderRadius: isSendByMe ? 
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)
            ):  
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
            ),
        ),
        child: Text(message, 
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            
          )
        ),
      ),
    );
  }
}