// ignore_for_file: file_names

class MessageModel {
  late String type;
  late String message;
  late String time;
  late String path;

  MessageModel(
      {required this.type,
      required this.message,
      required this.time,
      required this.path});
}
