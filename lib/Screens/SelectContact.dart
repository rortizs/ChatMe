// ignore_for_file: file_names
import 'package:clone_chat/CustomUI/ButtonCard.dart';
import 'package:clone_chat/CustomUI/ContactCard.dart';
import 'package:clone_chat/Model/Chat_Model.dart';
import 'package:clone_chat/Screens/CreateGroup.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "200 contacs",
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
            PopupMenuButton<String>(
              onSelected: (String value) {
                // ignore: avoid_print
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  /** open setting from user loged**/
                  const PopupMenuItem<String>(
                    value: 'Invite a friend',
                    child: Text('Invite a friend'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'contacts',
                    child: Text('contacts'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Refresh',
                    child: Text('Refresh'),
                  ),
                  /** exit user loged**/
                  const PopupMenuItem<String>(
                    value: 'Help',
                    child: Text('Help'),
                  ),
                ];
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: contacts.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const CreateGroup()));
                    },
                    child:
                        const ButtonCard(icon: Icons.group, name: "New group"));
              } else if (index == 1) {
                return const ButtonCard(
                    icon: Icons.person, name: "New contact");
              }
              return ContactCard(
                contact: contacts[index - 2],
              );
            }));
  }
}
