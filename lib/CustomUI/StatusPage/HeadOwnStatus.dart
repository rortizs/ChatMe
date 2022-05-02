// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: const [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.blueGrey,
            backgroundImage: AssetImage("assets/Person1.png"),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 10,
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  )))
        ],
      ),
      title: const Text("My Status",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      subtitle: const Text(
        "Tap to add status update",
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    );
  }
}
