// ignore_for_file: file_names

import 'package:clone_chat/CustomUI/StatusPage/HeadOwnStatus.dart';
import 'package:clone_chat/CustomUI/StatusPage/OtherStatus.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: const Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            const HeadOwnStatus(),
            label("Recent updates"),
            const OtherStatus(
              name: "John Doe",
              time: "Today at, 12:30 PM",
              imageName: "assets/Person3.png",
            ),
            const OtherStatus(
              name: "Richard Ortiz",
              time: "Today at, 12:30 PM",
              imageName: "assets/Person4.png",
            ),
            const OtherStatus(
              name: "David Ortiz",
              time: "Today at, 12:30 PM",
              imageName: "assets/Person1.png",
            ),
            const OtherStatus(
              name: "Alison Ortiz",
              time: "Today at, 12:30 PM",
              imageName: "assets/Person2.png",
            ),
            const SizedBox(
              height: 10,
            ),
            label("Viewed updates"),
            const OtherStatus(
              name: "John Doe",
              time: "Today at, 12:30 PM",
              imageName: "assets/Person3.png",
            ),
            const OtherStatus(
              name: "David Ortiz",
              time: "Today at, 12:30 PM",
              imageName: "assets/Person1.png",
            ),
            const OtherStatus(
              name: "Alison Ortiz",
              time: "Today at, 12:30 PM",
              imageName: "assets/Person2.png",
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(
          labelName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
