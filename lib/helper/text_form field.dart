import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_image_api/helper/ap_color.dart';

class MyTextField extends StatelessWidget {
  final String? lable;
  final List<TextInputFormatter>? textinputformatter;
  final TextEditingController controller;
  final String? Function(String?)? validater;
  final int? maxLength;
  final int? maxLine;
  final TextInputType? keybordtype;
  final String? hintText;
  final bool abscorbing;
  final void Function()? onTap;
  final bool obscureText;

  MyTextField({super.key,
    this.lable,
    this.textinputformatter,
    required this.controller,
    this.validater,
    this.maxLength,
    this.maxLine,
    this.keybordtype,
    this.hintText,
    this.abscorbing = false,
    this.onTap,
    this.obscureText=false });

  OutlineInputBorder border({
    Color color = Primary, required double width,
    //double width = 50,
  }) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable != null)
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text("$lable",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                )),
          ),
        InkWell(
          onTap: abscorbing ? onTap : null,
          child: AbsorbPointer(
            absorbing: abscorbing,
            child: TextFormField(
              obscureText:obscureText,
              cursorColor: Primary,
              controller: controller,
              maxLines: maxLine,
              maxLength: maxLength,
              validator: validater,
              keyboardType: keybordtype,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Primary,
              ),
              inputFormatters: textinputformatter,
              decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  hintText: hintText,
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                  border: border(
                    width: 0.75,
                  ),
                  focusedBorder: border(width: 1.2),
                  enabledBorder: border(
                    width: 0.75,
                  ),
                  disabledBorder: border(
                    width: 0.75,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
