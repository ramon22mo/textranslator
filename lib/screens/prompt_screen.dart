import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:textranslator/utility/language_dropdown.dart';
import 'package:textranslator/utility/translate_from.dart';
import 'package:textranslator/widgets/translate_button.dart';

import '../utility/translate_to.dart';

class PromptScreen extends StatefulWidget {
  final VoidCallback showHomeScreen;
  const PromptScreen({super.key, required this.showHomeScreen});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  String? selectedLanguageFrom;
  String? selectedLanguageTo;
  TextEditingController controller = TextEditingController();
  String _translatedText = "";
  bool _loading = false;

  void _handleLanguageChangeFrom(String? newLanguage) {
    setState(() {
      selectedLanguageFrom = newLanguage;
    });
  }

  void _handleLanguageChangeTo(String? newLanguage) {
    setState(() {
      selectedLanguageTo = newLanguage;
    });
  }

  void _swapLanguages() {
    setState(() {
      final temp = selectedLanguageFrom;
      selectedLanguageFrom = selectedLanguageTo;
      selectedLanguageTo = temp;
    });
    _translateText();
  }

  Future<void> _translateText() async {
    final apiKey = dotenv.env["GEMINI_API_KEY"];
    if (apiKey == null) {
      print("API Key is not available in the environment file");
      return;
    }

    final inputText = controller.text;
    final fromLanguage = selectedLanguageFrom;
    final toLanguage = selectedLanguageTo;

    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('What are you translating?')),
      );
      return;
    }

    if (fromLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('What language are you translating from?')),
      );
      return;
    }

    if (toLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('What language are you translating to?')),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
      final content = [
        Content.text(
          'Translate only "$inputText" from $fromLanguage to $toLanguage',
        )
      ];
      final response = await model.generateContent(content);

      setState(() {
        _translatedText = response.text!;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred while translating text"),
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Padding(
          padding: const EdgeInsets.only(
              top: 50.0,
              left: 16.0,
              right: 16.0
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFF6D1B7B).withOpacity(0.8),
                          width: 0.2,
                        )
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TexTranslation",
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      const Icon(
                        Icons.text_fields,
                        color: Color(0xFF000000),
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LanguageDropdown(
                        onLanguageChanged: _handleLanguageChangeFrom,
                        selectedLanguage: selectedLanguageFrom,
                      ),
                      GestureDetector(
                        onTap: _swapLanguages,
                        child: Icon(
                          Icons.swap_horiz_rounded,
                          color: const Color(0xFF6D1B7B).withOpacity(0.3),
                        ),
                      ),
                      LanguageDropdown(
                        onLanguageChanged: _handleLanguageChangeTo,
                        selectedLanguage: selectedLanguageTo,
                      ),
                    ],
                  ),
                ),
                /* Translate From */
                Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              height: 1.6,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Translate From ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                              if (selectedLanguageFrom != null)
                                TextSpan(
                                  text: selectedLanguageFrom ?? "Select Language",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF6D1B7B),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                /* Translate Input From */
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 223.0,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF6D1B7B).withOpacity(0.8),
                        width: 0.2,
                      ),
                    ),
                    child: TranslateFrom(controller: controller),
                  ),
                ),
                /* Translate To */
                Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              height: 1.6,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Translate To ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                              if (selectedLanguageTo != null)
                                TextSpan(
                                  text: selectedLanguageTo ?? "Select Language",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF6D1B7B),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                /* Translate To Container */
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 223.0,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF6D1B7B).withOpacity(0.8),
                        width: 0.2,
                      ),
                    ),
                    child: _loading
                        ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF6D1B7B),
                        ),
                      ),
                    ) : TranslateTo(translatedText: _translatedText),
                  ),
                ),
                /* Translate Button */
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TranslateButton(onPressed: _translateText),
                )
              ],
            ),
          )
      ),
    );
  }
}