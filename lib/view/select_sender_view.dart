import 'package:chat_sqlite/common_attribute/common_color.dart';
import 'package:chat_sqlite/common_attribute/common_value.dart';
import 'package:chat_sqlite/common_widget/common_text.dart';
import 'package:chat_sqlite/common_widget/common_text_button.dart';
import 'package:chat_sqlite/common_widget/common_text_form_field.dart';
import 'package:chat_sqlite/data_base_helper/data_base_helper.dart';
import 'package:chat_sqlite/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:chat_sqlite/provider/select_sender_provider.dart';
import 'package:chat_sqlite/view/select_receiver_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SelectSenderView extends StatelessWidget {
  const SelectSenderView({super.key});

  @override
  Widget build(BuildContext context) {

    final userNameController = TextEditingController();
    final userPasswordController = TextEditingController();
    const String validatorMessage = 'this field required';
    final _db =  DataBaseHelper();
    final _nameEditingController =  TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const CommonText(text: 'Select Sender', fontSize: TextSize.heading, fontWeight: TextWeight.semiBold),
        centerTitle: true,
        foregroundColor: white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        elevation: 10,
        backgroundColor: color2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: const CommonText(text: 'Add User',textAlign: TextAlign.center),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Padding(
                        padding: PaddingValue.xSmall,
                        child: CommonTextFormField(
                          controller: userNameController,
                          hintText: 'Enter User Name',
                          textInputType: TextInputType.text,
                          icon: const Icon(Icons.person),
                          iconSize: 1.0,
                          obscuringText: false,
                          onPressed: () => true,
                          validatorMessage: validatorMessage,
                          maxLine: 1,
                        ),
                      ),

                      Padding(
                        padding: PaddingValue.xSmall,
                        child: CommonTextFormField(
                          controller: userPasswordController,
                          hintText: 'Enter Password',
                          textInputType: TextInputType.text,
                          icon: const Icon(Icons.password),
                          iconSize: 1.0,
                          obscuringText: false,
                          onPressed: () => true,
                          validatorMessage: validatorMessage,
                          maxLine: 1,
                        ),
                      ),

                    ],
                  ),
                  actions: [
                       Consumer<SenderSideProvider>(
                         builder: (context, value,  child) {
                            return CommonTextButton(text: 'Add',onPressed: (){

                              _db.insertRegisterUserData(UserModel(
                                  userName: userNameController.text,
                                  userPassword: userPasswordController.text,
                                  userCreationTime: DateFormat('HH:mm:ss').format(DateTime.now()),
                              )).whenComplete((){
                                 value.future = _db.readRegisterUserData();
                              });
                              Navigator.pop(context);
                              userNameController.text = '';
                              userPasswordController.text = '';

                            });
                         },
                       ),
                      CommonTextButton(text: 'Cancel',onPressed: (){
                        Navigator.pop(context);
                      }),
                  ],

                );
              }
          );

        },
        child: Icon(Icons.add,color: white),
        backgroundColor: color2,
      ),

      body: Consumer<SenderSideProvider>(
        builder: (context, value, child) {
          return FutureBuilder<List<UserModel>>(
            future: _db.readRegisterUserData(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {

              final senderNameList = snapshot.data ?? <UserModel>[];

              return Padding(
                padding: PaddingValue.small,
                child: ListView.separated(
                  itemCount: senderNameList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      tileColor: color1,
                      leading: CircleAvatar(
                        backgroundColor: color2,
                        child: CommonText(text: senderNameList[index].userId.toString()),
                      ),
                      title: CommonText(
                        text: senderNameList[index].userName,
                        fontWeight: TextWeight.semiBold,
                        color: Colors.white,
                      ),
                      subtitle: CommonText(text: 'user created at : ${senderNameList[index].userCreationTime}', color: Colors.white),
                      trailing: Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(
                              onPressed: (){
                                _nameEditingController.text = senderNameList[index].userName??"";
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: CommonText(text: 'update name'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,

                                          children: [
                                            CommonTextFormField(
                                              controller: _nameEditingController,
                                              hintText: 'Enter Name',
                                              textInputType: TextInputType.text,
                                              icon: const Icon(Icons.person),
                                              iconSize: 1.0,
                                              obscuringText: false,
                                              onPressed: () => true,
                                              validatorMessage: 'email required',
                                            )
                                          ],
                                        ),
                                        actions: [

                                          CommonTextButton(text: 'Update',onPressed: (){
                                            _db.updateRegisterUserData(UserModel(
                                              userName: _nameEditingController.text,
                                              userId: senderNameList[index].userId,
                                            )).whenComplete((){
                                              value.future = _db.readRegisterUserData();
                                              Navigator.pop(context);
                                            });
                                          }),

                                          CommonTextButton(text: 'Cancel',onPressed: (){
                                            Navigator.pop(context);
                                          })

                                        ],
                                      );
                                    }
                                );
                              },
                              icon: Icon(Icons.edit,color: white),
                            ),

                            IconButton(
                              onPressed: (){

                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: CommonText(text: 'Delete'),
                                        content: CommonText(text: 'Confirm ?'),
                                        actions: [

                                          CommonTextButton(text: 'Delete',onPressed: (){
                                            _db.deleteRegisterUserData(senderNameList[index].userId ?? 0).whenComplete((){
                                              value.future = _db.readRegisterUserData();
                                            }).whenComplete((){
                                              value.future = _db.readRegisterUserData();
                                              Navigator.pop(context);
                                            });
                                          }),

                                          CommonTextButton(text: 'Cancel',onPressed: (){
                                            Navigator.pop(context);
                                          })

                                        ],
                                      );
                                    }
                                );
                              },
                              icon: Icon(Icons.delete,color: white),
                            ),

                          ],
                        ),
                      ),
                      onTap: (){
                        print('curr date ${DateFormat('dd/MM/yyyy').format(DateTime.now())}');
                        print('curr time ${DateFormat('HH:mm:ss').format(DateTime.now())}');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectReceiverView(senderId:senderNameList[index].userId ?? 0)));
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
