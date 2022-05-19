// ignore_for_file: file_names

import 'package:clone_chat/CustomUI/ButtonCard.dart';
import 'package:clone_chat/Model/Chat_Model.dart';
import 'package:clone_chat/Screens/Homescreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  //chat list
  List<ChatModel> chatmodels = [
    ChatModel(
        name: "Richard Ortiz",
        icon: "assets/person.svg",
        IsGroup: false,
        time: "11:04",
        currentMessage: "I love my life",
        status: true,
        id: 1),
    ChatModel(
        name: "David Ortiz",
        icon: "assets/person.svg",
        IsGroup: false,
        time: "10:04",
        currentMessage: "Dev is the most best",
        status: false,
        id: 2),
    ChatModel(
        name: "Alison Ortiz",
        icon: "assets/person.svg",
        IsGroup: false,
        time: "09:04",
        currentMessage: "coming soon",
        status: false,
        id: 3),
    // ChatModel(
    //     name: "groups digicom",
    //     icon: "assets/groups.svg",
    //     IsGroup: true,
    //     time: "18:04",
    //     currentMessage: "Dev is the best",
    //     status: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                sourceChat = chatmodels.removeAt(index);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => HomeScreen(
                            chatmodels: chatmodels,
                            sourchat: sourceChat,
                            onImageSend: (image) {
                              // ignore: avoid_print
                              print(image);
                            })));
              },
              child: ButtonCard(
                  name: chatmodels[index].name, icon: Icons.person))),
    );
  }
}
