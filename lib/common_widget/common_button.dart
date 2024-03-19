import 'package:chat_sqlite/common_attribute/common_color.dart';
import 'package:chat_sqlite/common_attribute/common_value.dart';
import 'package:chat_sqlite/common_widget/common_text.dart';
import 'package:flutter/material.dart';
class CommonButton extends StatelessWidget {

  final String? text;
  final VoidCallback? onPressed;

  const CommonButton({super.key, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal
      ),
      child: CommonText(text: text, color: white, fontSize: TextSize.title),
    );
  }
}
