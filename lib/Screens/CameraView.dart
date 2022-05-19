// ignore_for_file: file_names
import 'dart:io';

import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
   CameraView({Key? key, required this.path, required this.onImageSend})
      : super(key: key);

  final String path;
  final Function onImageSend;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.crop_rotate,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 27,
            ),
            onPressed: () {},
          ),
        ],
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Positioned(
              bottom: 0,
              // ignore: sized_box_for_whitespace
              child: Container(
                color: Colors.black54,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: _controller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add a caption....",
                    prefixIcon: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 17,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        onImageSend(
                          path,
                          _controller.text.trim(),
                          );
                      },
                      child: const CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
