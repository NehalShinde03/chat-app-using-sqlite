class ConversationMessageModel{

  final int? conversationId;
  final int? senderId;
  final int? receiverId;
  final String? conversationDate;
  final String? conversationTime;

  final int? messageId;
  final String? message;
  final String? messageDate;
  final String? messageTime;



  ConversationMessageModel({this.conversationId, this.senderId, this.receiverId,
    this.messageId, this.message, this.conversationDate, this.conversationTime,
    this.messageDate, this.messageTime});



  factory ConversationMessageModel.fromJson(Map<String, dynamic> json) => ConversationMessageModel(
    conversationId: json['conversationId'],
    senderId: json['senderId'],
    receiverId: json['receiverId'],
    conversationDate: json['conversationDate'],
    conversationTime: json['conversationTime'],

    messageId: json['messageId'],
    message: json['message'],
    messageDate: json['messageDate'],
    messageTime: json['messageTime'],
  );



  Map<String, dynamic> toJson() => {
    'conversationId':conversationId,
    'senderId':senderId,
    'receiverId':receiverId,
    'conversationDate':conversationDate,
    'conversationTime':conversationTime,

    'messageId':messageId,
    'message':message,
    'messageDate':messageDate,
    'messageTime':messageTime,
  };

}