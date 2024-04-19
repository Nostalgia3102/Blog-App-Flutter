import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  const AuthGradientButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          AppPalette.gradient1,
          AppPalette.gradient2,
          AppPalette.gradient3
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight), 
        borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 70),
        backgroundColor: AppPalette.transparentColor,
        shadowColor: AppPalette.transparentColor
      ),
        child:Text(text, style: const TextStyle(color: Colors.white, fontSize: 18),),),
    );
  }
}