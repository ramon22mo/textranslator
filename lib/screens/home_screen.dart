// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textranslator/constants.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback showPromptScreen;

  const HomeScreen({super.key, required this.showPromptScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/worldmap.png"),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png"),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(height: 1.6),
                    children: <InlineSpan>[
                      const TextSpan(
                        text: "Translate",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                      TextSpan(
                        text: " Any \n",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor.withOpacity(0.3),
                        ),
                      ),
                      const TextSpan(
                        text: "Word \n",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(height: 35.0),
                      ),
                      const TextSpan(
                        text: "Make communication across \n",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: blackColor,
                        ),
                      ),
                      const TextSpan(
                        text: "languages easy. \n",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: showPromptScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.translate, color: whiteColor),
                      SizedBox(width: 8.0),
                      Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}