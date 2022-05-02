// ignore_for_file: file_names

import 'package:clone_chat/Model/Chat_Model.dart';
import 'package:clone_chat/pages/CameraPage.dart';
import 'package:clone_chat/pages/ChatPage.dart';
import 'package:clone_chat/pages/StatusPage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.chatmodels, required this.sourchat})
      : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar contains the tab bar and title from application
      appBar: AppBar(
        //title of the app
        title: const Text('ChatMe'),
        //acction button
        actions: [
          //button to open the search
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          //button to open the actions sheet screen popup
          PopupMenuButton<String>(
            onSelected: (String value) {
              // ignore: avoid_print
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                /** open setting from user loged**/
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                /** exit user loged**/
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: 'Chats',
            ),
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Calls',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const CameraPage(),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourchat: widget.sourchat,
          ),
          const StatusPage(),
          const Text("calls"),
        ],
      ),
    );
  }
}
