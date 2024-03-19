import 'package:chat_sqlite/common_attribute/common_color.dart';
import 'package:chat_sqlite/common_attribute/common_value.dart';
import 'package:chat_sqlite/common_widget/common_text.dart';
import 'package:chat_sqlite/common_widget/common_text_form_field.dart';
import 'package:chat_sqlite/data_base_helper/data_base_helper.dart';
import 'package:chat_sqlite/model/conversation_model.dart';
import 'package:chat_sqlite/model/message_model.dart';
import 'package:chat_sqlite/provider/chatting_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChattingView extends StatefulWidget {

  final int? senderId;
  final int? receiverId;

  const ChattingView({super.key, this.senderId, this.receiverId});

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {

  final chatController = TextEditingController();
  bool chatMessageAdjust = false;
  final DataBaseHelper _db = DataBaseHelper();

  List isIdAvailable=[];


  @override
  void initState(){
    super.initState();
    idIsAvailable(context);
  }

  //check if conversation already created or not, if not created then add new conversation into table otherwise ignore
  Future<void> idIsAvailable(BuildContext context) async{
    final value = Provider.of<ChattingViewProvider>(context,listen: false);
    isIdAvailable = await _db.readSpecificDataInConversation(widget.senderId??0, widget.receiverId??0);
    if(isIdAvailable.isEmpty){
      _db.insertConversation(ConversationModel(
          senderId: widget.senderId,
          receiverId: widget.receiverId,
          conversationDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
          conversationTime: DateFormat('HH:mm:ss').format(DateTime.now())
      )).whenComplete((){
          idIsAvailable;
      });
    }
    for (var map in isIdAvailable) {
      value.getConversationId = map['conversationId'];
      value.getSenderId = map['senderId'];
      value.getReceiverId = map['receiverId'];
    }
  }


  @override
  Widget build(BuildContext context) {

    final value = Provider.of<ChattingViewProvider>(context,listen: false);
    value.message = Future.delayed(const Duration(seconds:2),(){
      return _db.readMessages(value.getConversationId??0);
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('person ${widget.senderId} - ${widget.receiverId}'),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          side: BorderSide(color: color2, width: 2),
        ),
        backgroundColor: white,
        actions: [
          Consumer<ChattingViewProvider>(
            builder: (context, value, child) {
              return Container(

                //true then show delete icon otherwise hide
                  child: value.msgDeletion == true
                      ? Row(
                    children: [

                      //one chat delete
                      IconButton(
                          onPressed: () {
                            _db.deleteOneMessage(value.messageId??0).whenComplete((){
                              value.message = Future.delayed(const Duration(seconds:0),(){
                                return _db.readMessages(value.getConversationId??0);
                              });
                            });
                            value.msgDeletion = false;
                          },
                          icon: const Icon(Icons.delete)),
                      //all chat delete
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const CommonText(
                                        text: 'Conversation'),
                                    content: const CommonText(
                                        text:
                                        'are you sure want to delete all chat ?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            _db.deleteAllMessages(value.getConversationId??0).whenComplete((){
                                              value.message = Future.delayed(const Duration(seconds:0),(){
                                                return _db.readMessages(value.getConversationId??0);
                                              });
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const CommonText(
                                              text: 'yes')),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const CommonText(
                                              text: 'no'))
                                    ],
                                  );
                                });
                            value.msgDeletion = false;
                          },
                          icon: const Icon(Icons.delete_forever)),
                    ],
                  )
                      : const SizedBox());
            },
          )
        ],
        //leading: Icon(Icons.arrow_back_ios_new_rounded,),
      ),
      body: Column(
        children: [

          //display message
          Consumer<ChattingViewProvider>(
            builder: (context, value, child) {
              return FutureBuilder<List<MessageModel>>(
                future: value.message,
                builder: (context, AsyncSnapshot<List<MessageModel>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Expanded(child: Center(child: SizedBox()));
                  }else if(snapshot.data!.isEmpty){
                    return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/no_conversation.png',scale: 7),
                            const CommonText(text: 'No Conversation Available')
                          ],
                        ));
                  }else{
                    final message = snapshot.data ?? <MessageModel>[];
                    return Flexible(
                      child: ListView.separated(
                        itemCount: message.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              value.msgDeletion = true;
                              value.messageId = message[index].messageId;
                            },
                            onTap: () {
                              value.msgDeletion = false;
                            },
                            child: Column(
                              children: [
                                Align(
                                  alignment: message[index].senderId == widget.senderId
                                      ? Alignment.centerRight
                                      :Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsetsDirectional.all(10.0),
                                          margin: const EdgeInsetsDirectional.only(top: 10.0),
                                          decoration: BoxDecoration(
                                              color: message[index].senderId == widget.senderId ? color1 : white,
                                              borderRadius:  message[index].senderId == widget.senderId
                                                  ? const BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20),topLeft: Radius.circular(20))
                                                  : const BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                              border: Border.all(color: message[index].senderId == widget.senderId ? white : color2)),
                                          child: CommonText(text: message[index].messages,
                                              color: message[index].senderId == widget.senderId ? white : color1, fontSize: TextSize.title)),

                                      CommonText(text: '${message[index].messageTime}', color: color1, fontSize: TextSize.content),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox();
                        },
                      ),
                    );
                  }
                },
              );
            },
          ),

          // typing textField
          Padding(
              padding: PaddingValue.small,
              child: CommonTextFormField(
                controller: chatController,
                hintText: 'Type Something...',
                textInputType: TextInputType.text,
                icon: Icon(
                  Icons.telegram,
                  color: indigo,
                ),
                iconSize: 1.5,
                obscuringText: false,
                // onChanged: (val) {
                //   val.toString().isNotEmpty
                //       ? value.isTypingTextFieldEmpty = true
                //       : value.isTypingTextFieldEmpty = false;
                // },
                onPressed: () async{
                  if (chatController.text != "") {
                    _db.insertMessage(MessageModel(
                      messageDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      messageTime: DateFormat('HH:mm:ss').format(DateTime.now()),
                      messages: chatController.text,
                      conversationId: value.getConversationId,
                      senderId: widget.senderId,
                      receiverId: widget.receiverId,
                    )).whenComplete((){
                      value.message = Future.delayed(const Duration(seconds:0),(){
                        return _db.readMessages(value.getConversationId??0);
                      });
                      chatController.text="";
                    });
                  }
                }
              )
          )
        ],
      ),
    );
  }
}