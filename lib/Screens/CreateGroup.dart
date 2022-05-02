// ignore_for_file: file_names
import 'package:clone_chat/CustomUI/AvatarCard.dart';
import 'package:clone_chat/CustomUI/ContactCard.dart';
import 'package:clone_chat/Model/Chat_Model.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Richard Ortiz",
      icon: "assets/person.svg",
      IsGroup: false,
      time: "11:04",
      currentMessage: "I love my life",
      status: true,
      id: 1,
    ),
    ChatModel(
      name: "David Ortiz",
      icon: "assets/person.svg",
      IsGroup: false,
      time: "10:04",
      currentMessage: "Dev is the most best",
      status: false,
      id: 2,
    ),
    ChatModel(
        name: "Alison Ortiz",
        icon: "assets/person.svg",
        IsGroup: false,
        time: "09:04",
        currentMessage: "coming soon",
        status: true,
        id: 3,
        ),
    ChatModel(
      name: "groups digicom",
      icon: "assets/groups.svg",
      IsGroup: true,
      time: "18:04",
      currentMessage: "Dev is the best",
      status: false,
      id: 4,
    ),
  ];
  List<ChatModel> groupsmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, size: 24),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groupsmember.isNotEmpty ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index - 1].select == true) {
                          groupsmember.remove(contacts[index - 1]);
                          contacts[index - 1].select = false;
                        } else {
                          groupsmember.add(contacts[index - 1]);
                          contacts[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
                }),
            groupsmember.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.lime[50],
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              if (contacts[index].select == true) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      groupsmember.remove(contacts[index]);
                                      contacts[index].select = false;
                                    });
                                  },
                                  child: AvatarCard(
                                    contact: contacts[index],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  )
                : Container(),
          ],
        ));
  }
}
