//ignore_for_file: non_constant_identifier_names, file_names

class ChatModel {
  String name;
  String icon;
  bool IsGroup;
  String time;
  String currentMessage;
  bool status;
  bool select = false;
  int id;

  ChatModel({
    required this.name,
    required this.icon,
    required this.IsGroup,
    required this.time,
    required this.currentMessage,
    required this.status,
    this.select = false,
    required this.id,
  });
}
