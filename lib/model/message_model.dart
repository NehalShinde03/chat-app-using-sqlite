class MessageModel{

  int? messageId;
  int? conversationId;
  late final int? senderId;
  final int? receiverId;
  final String? messages;
  final String? messageDate;
  final String? messageTime;

  MessageModel({this.messageId, this.conversationId, this.senderId, this.receiverId, this.messages, this.messageDate, this.messageTime});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      messageId: json['messageId'],
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      messages: json['messages'],
      messageDate: json['messageDate'],
      messageTime: json['messageTime'],
  );

  Map<String, dynamic> toJson() => {
      'messageId':messageId,
      'conversationId':conversationId,
      'senderId':senderId,
      'receiverId':receiverId,
      'messages':messages,
      'messageDate':messageDate,
      'messageTime':messageTime,
  };

}