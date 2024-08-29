import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textranslator/constants.dart';

class TranslateTo extends StatefulWidget {
  final String translatedText;
  const TranslateTo({super.key, required this.translatedText});

  @override
  State<TranslateTo> createState() => _TranslateToState();
}

class _TranslateToState extends State<TranslateTo> {
  final FlutterTts _flutterTts = FlutterTts();

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Copied to clipboard"),
        ),
      );
    });
  }

  Future<void> _handleVolumeUp() async {
    await _flutterTts.speak(widget.translatedText);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: SingleChildScrollView(
              child: Text(
                widget.translatedText,
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: blackColor,
                ),
              ),
            ),
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 12.0
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: primaryColor.withOpacity(0.8),
                width: 0.2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Copy to clipboard icon
              GestureDetector(
                onTap: () => _copyToClipboard(widget.translatedText),
                child: Icon(
                  Icons.copy_all_outlined,
                  color: primaryColor.withOpacity(0.8),
                ),
              ),
              // Volume up icon
              GestureDetector(
                onTap: _handleVolumeUp,
                child: Icon(
                  Icons.volume_up_outlined,
                  color: primaryColor.withOpacity(0.8),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
