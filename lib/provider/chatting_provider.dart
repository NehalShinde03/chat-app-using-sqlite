import 'package:chat_sqlite/model/message_model.dart';
import 'package:flutter/material.dart';

class ChattingViewProvider extends ChangeNotifier{

  int? getConversationId;
  int? getSenderId;
  int? getReceiverId;
  int? messageId;

  // //to read conversation in db
  // Future<List<ConversationModel>>? _future;// = DataBaseHelper().readConversation();
  // Future<List<ConversationModel>>? get future => _future;
  // set future(val){
  //   _future = val;
  //   notifyListeners();
  // }



  //enable send icon on textfield when textfield is not empty
  bool _isTypingTextFieldEmpty = true;
  bool get isTypingTextFieldEmpty => _isTypingTextFieldEmpty;
  set isTypingTextFieldEmpty(bool val){
    _isTypingTextFieldEmpty = val;
    notifyListeners();
  }


  //for message deletion
  bool _msgDeletion = false;
  bool get msgDeletion => _msgDeletion;
  set msgDeletion(bool val){
    _msgDeletion = val;
    notifyListeners();
  }


  // ConversationModel? _conversationModel;
  // ConversationModel? get conversationModel => _conversationModel;
  // set conversationModel(ConversationModel? val){
  //   _conversationModel = val;
  //   notifyListeners();
  // }
  //
  // MessageModel? _messageModel;
  // MessageModel? get messageModel => _messageModel;
  // set messageModel(MessageModel? val){
  //   _messageModel = val;
  //   notifyListeners();
  // }

  Future<List<MessageModel>>? _message;
  Future<List<MessageModel>>? get message => _message;
  set message(val){
    _message = val;
    notifyListeners();
  }

}

