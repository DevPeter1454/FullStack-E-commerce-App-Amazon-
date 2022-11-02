import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  const CustomButton({Key? key, required this.text, required this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: color,
          minimumSize: const Size(double.infinity, 50)),
      child: Text(text, style: TextStyle(color: color == null ? Colors.white : Colors.black),),
    );
  }
}
