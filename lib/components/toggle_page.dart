// lib/components/toggle_page.dart
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/prompt_screen.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  bool _showHomeScreen = true;

  void _toggleScreen() {
    setState(() {
      _showHomeScreen = !_showHomeScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showHomeScreen) {
      return HomeScreen(showPromptScreen: _toggleScreen);
    } else {
      return PromptScreen(showHomeScreen: _toggleScreen);
    }
  }
}