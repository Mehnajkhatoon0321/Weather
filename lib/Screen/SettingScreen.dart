import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Bloc/TheamsProvider/theam_provider.dart';
import 'package:weather/Utils/flutter_font_style.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Center(
            child: Text("Setting", style: FTextStyle.appTitleStyle),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Image.asset(
              "assets/images/backButton.png",
              height: 10,
              width: 10,
            ),
          ),
        ),
      
      ),
      body: Center(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return Switch(
              value: themeProvider.isDarkTheme,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            );
          },
        ),
      ),
    );
  }
}
