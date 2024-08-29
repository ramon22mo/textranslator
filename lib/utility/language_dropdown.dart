import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textranslator/constants.dart';

class LanguageDropdown extends StatefulWidget {
  final ValueChanged<String?> onLanguageChanged;
  final String? selectedLanguage;

  const LanguageDropdown({
    super.key,
    required this.onLanguageChanged,
    this.selectedLanguage,
  });

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final List<Map<String, String>> languageData = [
    {'countryLanguage': 'English - US', 'countryImage': 'assets/images/usa.png'},
    {'countryLanguage': 'English - UK', 'countryImage': 'assets/images/britain.png'},
    {'countryLanguage': 'Spain', 'countryImage': 'assets/images/spain.png'},
    {'countryLanguage': 'Russian', 'countryImage': 'assets/images/russia.png'},
    {'countryLanguage': 'Italian', 'countryImage': 'assets/images/italy.png'},
    {'countryLanguage': 'French', 'countryImage': 'assets/images/france.png'},
    {'countryLanguage': 'Arabic', 'countryImage': 'assets/images/arabic.png'},
    {'countryLanguage': 'Chinese', 'countryImage': 'assets/images/china.png'},
    {'countryLanguage': 'German', 'countryImage': 'assets/images/germany.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: whiteColor,
        border: Border.all(
          color: primaryColor.withOpacity(0.8),
          width: 0.1,
        ),
      ),
      child: DropdownButton<String>(
        value: widget.selectedLanguage,
        hint: Text(
          "Select Language",
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            color: blackColor.withOpacity(0.5),
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: primaryColor.withOpacity(0.3),
          ),
        ),
        underline: Container(
          color: Colors.transparent,
        ),
        dropdownColor: whiteColor,
        items: languageData.map((country) {
          return DropdownMenuItem<String>(
            value: country['countryLanguage'],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    country['countryImage']!,
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    country['countryLanguage']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: blackColor.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          widget.onLanguageChanged(newValue);
        },
      ),
    );
  }
}