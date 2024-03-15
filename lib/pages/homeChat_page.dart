import 'package:flutter/material.dart';
import 'package:flutter_api/pages/ChatPage.dart';

class HomeChatPage extends StatefulWidget {
  const HomeChatPage({super.key});

  @override
  State<HomeChatPage> createState() => _HomeChatPageState();
}

class _HomeChatPageState extends State<HomeChatPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: const Row(
              children: [
                const Icon(
                  Icons.group,
                  color: Colors.white,
                ),
                const Text(
                  ' Group Chat Apps',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
            width: size.width * 1,
            height: size.height * 0.1,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: size.width * 1,
              height: size.height * 0.1,
              child: Row(
                children: [
                  CircleAvatar(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Group Chat 1',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                  )
                ],
              ),
              color: Colors.blueGrey,
              // child: ,
            ),
          )
        ],
      ),
    );
  }
}
