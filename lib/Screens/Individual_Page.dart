// ignore_for_file: file_names, sized_box_for_whitespace, avoid_unnecessary_containers, library_prefixes, unnecessary_null_comparison

import 'dart:convert';

import 'package:clone_chat/CustomUI/OwnFileCard.dart';
import 'package:clone_chat/CustomUI/OwnMessageCard.dart';
import 'package:clone_chat/CustomUI/ReplayCard.dart';
import 'package:clone_chat/CustomUI/ReplyFileCard.dart';
import 'package:clone_chat/Model/Chat_Model.dart';
import 'package:clone_chat/Model/MessageModel.dart';
import 'package:clone_chat/Screens/CameraScreen.dart';
import 'package:clone_chat/Screens/CameraView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourchat})
      : super(key: key);
  //chatModel to set database
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  int popTime = 0;

  @override
  void initState() {
    super.initState();
    coonect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void coonect() {
    socket = IO.io("http://192.168.1.73:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();
    socket.emit("signin", widget.sourchat.id);
    // ignore: avoid_print
    socket.onConnect((data) {
      // ignore: avoid_print
      print("connected");
      socket.on("message", (msg) {
        // ignore: avoid_print
        print(msg);
        setMessage(
          "destination",
          msg["message"],
          msg["path"],
        );
        //animation for scroll
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    // ignore: avoid_print
    print(socket.connected);
  }

  void sendMessages(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        path: path,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
  }

  void onImageSend(String path, String message) async {
    print("Hey there working $path");
    for (var i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });

    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.1.73:3000/routes/addimage"));
    request.files.add(
      await http.MultipartFile.fromPath("img", path),
    );
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);
    setMessage("source", message, path);

    socket.emit("message", {
      "message": message,
      "sourceId": widget.sourchat.id,
      "targetId": widget.chatModel.id,
      "path": data['path'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        widget.chatModel.IsGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.chatModel.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text("Last seen today at 12:05",
                          style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.videocam),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.call),
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
                        value: 'View Contact',
                        child: Text('View Contact'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Media, links, and docs',
                        child: Text('Media, links, and docs'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Chat web',
                        child: Text('Chat Web'),
                      ),
                      /** exit user loged**/
                      const PopupMenuItem<String>(
                        value: 'settings',
                        child: Text('Settings'),
                      ),
                    ];
                  },
                )
              ],
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  //chats list onwMessages and ReplayMessages
                  Expanded(
                    //height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(height: 70);
                        }
                        if (messages[index].type == "source") {
                          if (messages[index].path != null) {
                            return OwnFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        } else {
                          return ReplayCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                    margin: const EdgeInsets.only(
                                        left: 6, right: 4, bottom: 4, top: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: _controller,
                                      focusNode: focusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        // ignore: prefer_is_empty
                                        if (value.length > 0) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon:
                                                  const Icon(Icons.attach_file),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (builder) =>
                                                        _bottomSheet());
                                              },
                                            ),
                                            IconButton(
                                              icon:
                                                  const Icon(Icons.camera_alt),
                                              onPressed: () {
                                                setState(() {
                                                  popTime = 2;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            CameraScreen(
                                                              onImageSend:
                                                                  onImageSend,
                                                            )));
                                              },
                                            ),
                                          ],
                                        ),
                                        contentPadding: const EdgeInsets.all(5),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, right: 5, left: 2),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: const Color(0xFFF5F5F5),
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut);
                                        //send message
                                        sendMessages(
                                          _controller.text,
                                          widget.sourchat.id,
                                          widget.chatModel.id,
                                          "",
                                        );
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  _bottomSheet() {
    return Container(
      height: 178,
      width: 200,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      child: iconCreation(
                          Icons.insert_drive_file, Colors.indigo, "Document"),
                      onTap: () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                      child:
                          iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                      onTap: () {
                        setState(() {
                          popTime = 3;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CameraScreen(
                                      onImageSend: onImageSend,
                                    )));
                      }),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: iconCreation(
                        Icons.insert_photo, Colors.purple, "Gallery"),
                    onTap: () async {
                      setState(() {
                        popTime = 2;
                      });
                      image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CameraView(
                                    path: image!.path,
                                    onImageSend: onImageSend,
                                  )));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
