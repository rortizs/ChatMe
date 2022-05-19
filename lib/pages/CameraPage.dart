// ignore_for_file: file_names
import 'package:clone_chat/Screens/CameraScreen.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key, required this.onImageSend}) : super(key: key);
  final Function onImageSend;

  @override
  Widget build(BuildContext context) {
    return CameraScreen(
      onImageSend: onImageSend,
    );
  }
}
