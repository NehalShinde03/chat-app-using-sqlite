class ConversationModel{

  int? conversationId;
  late final int? senderId;
  final int? receiverId;
  final String? conversationDate;
  final String? conversationTime;

  ConversationModel({this.conversationId, this.senderId, this.receiverId, this.conversationDate, this.conversationTime});

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      conversationDate: json['conversationDate'],
      conversationTime: json['conversationTime'],
  );

  Map<String, dynamic> toJson() => {
    'conversationId':conversationId,
    'senderId':senderId,
    'receiverId':receiverId,
    'conversationDate':conversationDate,
    'conversationTime':conversationTime,
  };

}