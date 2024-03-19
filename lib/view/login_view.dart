import 'package:chat_sqlite/common_attribute/common_value.dart';
import 'package:chat_sqlite/common_widget/common_button.dart';
import 'package:chat_sqlite/common_widget/common_text.dart';
import 'package:chat_sqlite/common_widget/common_text_form_field.dart';
import 'package:chat_sqlite/provider/login_provider.dart';
import 'package:chat_sqlite/view/select_sender_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';



class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {

  final emailAddressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  bool isPasswordVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final snackBar = SnackBar(
      content: CommonText(text: 'Credential Wrong'),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsetsDirectional.all(5),
      action: SnackBarAction(label: 'Ok', onPressed: (){
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }),
    );

    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Center(
          child: SizedBox(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 20),
                    child: CommonText(text: 'Sing in', fontSize: TextSize.largeHHeading, fontWeight: TextWeight.extraBold),
                  ),

                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 30),
                    child: CommonText(text: 'Welcome Back...', fontSize: TextSize.subTitle, fontWeight: TextWeight.semiBold),
                  ),

                  const Gap(50),

                  Padding(
                    padding: PaddingValue.medium,
                    child: CommonTextFormField(
                      controller: emailAddressTextEditingController,
                      hintText: 'Enter Email',
                      textInputType: TextInputType.emailAddress,
                      icon: const Icon(Icons.email),
                      iconSize: 1.0,
                      obscuringText: false,
                      onPressed: () => true,
                      validatorMessage: 'email required',
                    ),
                  ),

                  Consumer<LoginProvider>(
                    builder: (context, value, child) {
                        return Padding(
                          padding: PaddingValue.medium,
                          child: CommonTextFormField(
                            controller: passwordTextEditingController,
                              hintText: 'Enter Password',
                              obscuringText: value.isPasswordVisible,
                              textInputType: TextInputType.visiblePassword,
                              validatorMessage: 'password required',
                              onPressed: () {
                                value.isPasswordVisible = !value.isPasswordVisible;
                              },
                              icon: value.isPasswordVisible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                            iconSize: 1.0,
                            maxLine: 1,
                          ),
                        );
                    },
                  ),

                  const Gap(20),

                  Center(
                    child: CommonButton(
                      text: 'Sign In',
                      onPressed: (){
                        if(formKey.currentState!.validate()) {
                          if(emailAddressTextEditingController.text == 'n@gmail.com' &&
                              passwordTextEditingController.text == '123'){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SelectSenderView()));
                          }
                          else{
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }},
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

}