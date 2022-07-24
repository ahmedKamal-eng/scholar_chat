
class Message{
  final String message;
  final String id;
  Message(this.message,this.id);

  factory Message.fromJson(data)
  {
    return Message(data['message'],data['id']);
  }
}