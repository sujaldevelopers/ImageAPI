import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool IsLoding;

  const   RoundButton({
    super.key,
    required this.text,
    required this.onTap,
    this.IsLoding=false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.brown.shade800,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: IsLoding
                ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,)
                : Text(
              text,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
