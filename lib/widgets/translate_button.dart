import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textranslator/constants.dart';

class TranslateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TranslateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 60.0
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
             padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 170.0),
            backgroundColor: primaryColor.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            "Translate",
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )
          )
      ),
    );
  }
}
