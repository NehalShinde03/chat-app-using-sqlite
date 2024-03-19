import 'package:chat_sqlite/common_attribute/common_color.dart';
import 'package:chat_sqlite/common_attribute/common_value.dart';
import 'package:chat_sqlite/common_widget/common_text.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {

  final String? text;
  final VoidCallback? onPressed;

  const CommonTextButton({super.key, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: CommonText(text: text,color: color1,fontSize: TextSize.title, fontWeight: TextWeight.semiBold)
    );
  }
}
