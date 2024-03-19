import 'package:chat_sqlite/common_attribute/common_color.dart';
import 'package:chat_sqlite/common_attribute/common_value.dart';
import 'package:chat_sqlite/common_widget/common_text.dart';
import 'package:chat_sqlite/data_base_helper/data_base_helper.dart';
import 'package:chat_sqlite/model/user_model.dart';
import 'package:chat_sqlite/provider/select_sender_provider.dart';
import 'package:chat_sqlite/view/chatting_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SelectReceiverView extends StatelessWidget {

  final int? senderId;
  const SelectReceiverView({super.key, this.senderId});

  @override
  Widget build(BuildContext context) {

    final _db =  DataBaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: const CommonText(text: 'Select Receiver', fontSize: TextSize.heading, fontWeight: TextWeight.semiBold),
        centerTitle: true,
        foregroundColor: white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        elevation: 10,
        backgroundColor: color2,
      ),

      body: Consumer<SenderSideProvider>(
        builder: (context, value, child) {
          return FutureBuilder<List<UserModel>>(
            future: _db.readRegisterUserDataAcceptSender(senderId??0),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {

              //store UserModel data
              final receiverNameList = snapshot.data ?? <UserModel>[];

              return Padding(
                padding: PaddingValue.small,
                child: ListView.separated(
                  itemCount: receiverNameList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      tileColor: color1,
                      leading: CircleAvatar(
                        child: CommonText(text: '${receiverNameList[index].userId??0}'),//Icon(Icons.person),
                        backgroundColor: color2,
                      ),
                      title: CommonText(
                        text: receiverNameList[index].userName,
                        fontWeight: TextWeight.semiBold,
                        color: Colors.white,
                      ),
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingView(
                         senderId: senderId, receiverId: receiverNameList[index].userId??0,
                       )));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(5);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
