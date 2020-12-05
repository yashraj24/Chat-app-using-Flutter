import 'package:WeChat/helper/authenticate.dart';
import 'package:WeChat/helper/constants.dart';
import 'package:WeChat/helper/helperfunction.dart';
import 'package:WeChat/services/auth.dart';
import 'package:WeChat/services/database.dart';
import 'package:WeChat/views/conversation_screen.dart';
import 'package:WeChat/views/search.dart';
import 'package:WeChat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context , snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return ChatRoomtile(
              snapshot.data.documents[index].data["chatroomid"]
              .toString().replaceAll("_", "")
              .replaceAll(Constants.myName, ""),
              snapshot.data.documents[index].data["chatroomid"]
            );
          }) : Container();
      }
    );
  }

  @override
  void initState() {
    getUserInfo();
    
    super.initState();
  }

  getUserInfo() async{
      Constants.myName = await HelperFuntion.getUserNameSharedPreference();
    setState(() {
      databaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomStream = value;

      });
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo(3).png", height: 180,width: 100,),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.singOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class ChatRoomtile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomtile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
         children: [
           Container(
             height: 40,
             width: 40,
             alignment: Alignment.center,
             decoration: BoxDecoration(
               color: Colors.redAccent,
               borderRadius: BorderRadius.circular(40),
             ),
             child: Text("${userName.substring(0,1).toUpperCase()}",
             style: mediumtextstyle(),),
           ),
           SizedBox(width: 8,),
           Text(userName , style: mediumtextstyle(),),
         ], 
        ),
      ),
    );
  }
}