class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  
  ChatModel({this.name, this.message, this.time, this.avatarUrl});
}

List<ChatModel> getDummyChat() {
  return [
    new ChatModel(
      name: "Bounty Hunter",
      message: "Preciso de gold!",
      time: createTime(10),
      avatarUrl: "https://source.unsplash.com/random/150x150",
    ),
    new ChatModel(
      name: "Shadow Fiend",
      message: "Estou farmando!",
      time: createTime(3),
      avatarUrl: "https://source.unsplash.com/random/150x150",
    ),
    new ChatModel(
      name: "Drow Ranger",
      message: "Vou fechar minha Butterfly!",
      time: createTime(0),
      avatarUrl: "https://source.unsplash.com/random/150x150",
    ),
    new ChatModel(
      name: "Templar Assasin",
      message: "Denied!",
      time: createTime(8),
      avatarUrl: "https://source.unsplash.com/random/150x150",
    ),
    new ChatModel(
      name: "Dragon Knight",
      message: "POR NÁRNIA!!!",
      time: createTime(23),
      avatarUrl: "https://source.unsplash.com/random/150x150",
    ),
  ];
}

String createTime(int hour) {
  var now = DateTime.now();

  if (hour > 23 || hour < 1) {
    hour = now.hour;
  }

  var date = new DateTime(
    now.year, 
    now.month, 
    now.day, 
    hour, 
    now.minute - hour, 
    now.second, 
    now.millisecond, 
    now.microsecond,
  );

  return date.hour.toString() +":"+ date.minute.toString();
}