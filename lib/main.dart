import 'package:chat_sqlite/provider/chatting_provider.dart';
import 'package:chat_sqlite/provider/login_provider.dart';
import 'package:chat_sqlite/provider/select_sender_provider.dart';
import 'package:chat_sqlite/view/chatting_view.dart';
import 'package:chat_sqlite/view/select_sender_view.dart';
import 'package:chat_sqlite/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ChattingViewProvider()),
        ChangeNotifierProvider(create: (context) => SenderSideProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginView(),
       // home: const SelectSenderView(),
      ),
    );
  }
}