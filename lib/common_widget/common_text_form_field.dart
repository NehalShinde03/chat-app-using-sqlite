import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {

  final TextEditingController? controller;
  final String? hintText;
  final String? validatorMessage;
  final ValueChanged? onChanged;
  final TextInputType? textInputType;
  final Widget icon;
  final VoidCallback? onPressed;
  final String? obscuringCharacter;
  final bool? obscuringText;
  final double? iconSize;
  final int? minLine;
  final int? maxLine;


  const CommonTextFormField({super.key, this.controller, this.hintText, this.validatorMessage, this.onChanged, this.textInputType, required this.icon, this.onPressed, this.obscuringCharacter, this.obscuringText, this.iconSize, this.minLine, this.maxLine});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      obscureText: obscuringText!,
      controller: controller,
      validator: (value){
        if(value!.isEmpty){
          return '$validatorMessage';
        }
        return null;
      },
      onChanged: onChanged,
      keyboardType: textInputType,
      minLines: minLine,
      maxLines: maxLine,
      decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      suffixIcon: Transform.scale(
        scale: iconSize,
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    )
    );
  }
}

/**/