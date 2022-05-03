import 'package:camera/camera.dart';
import 'package:clone_chat/NewScreen/LandingScreen.dart';
import 'package:clone_chat/Screens/CameraScreen.dart';
import 'package:clone_chat/Screens/Homescreen.dart';
import 'package:clone_chat/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

//void main() => runApp(const MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        fontFamily: "OpenSans",
      ),
      home: const LandingScreen(),
    );
  }
}
