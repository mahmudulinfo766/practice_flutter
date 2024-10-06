import 'package:flutter/material.dart';
import 'package:mach_managed/bird_game/flappy_bird_game.dart';
import 'package:mach_managed/get_live_data.dart';
import 'package:mach_managed/user/audio_player.dart';
import 'package:mach_managed/user/character_list_creen.dart';
import 'package:mach_managed/user/custom_chat_screen.dart';
import 'package:mach_managed/user/custom_imagepicker.dart';
import 'package:mach_managed/user/image_picker_and_edit.dart';
import 'package:mach_managed/user/image_picker_chat.dart';
import 'package:mach_managed/user/image_picker_screen.dart';

import 'user/method_channel.dart';

class PageList extends StatelessWidget {
  const PageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          inkWellButton(
            title: "Live Sheet Data",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LiveSheetData()),
            ),
          ),
          inkWellButton(
            title: "Sheet Data",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CharacterListScreen()),
            ),
          ),
          inkWellButton(
            title: "Image Picker",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagePickerScreen()),
            ),
          ),
          inkWellButton(
            title: "Image Picker chat",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            ),
          ),
          inkWellButton(
            title: "Custom Chat Screen",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomChatScreen()),
            ),
          ),
          inkWellButton(
            title: "Image Picker Popup",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagePickerPopup()),
            ),
          ),
          inkWellButton(
            title: "Audio Player Screen",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SimpleExampleApp()),
            ),
          ),
          inkWellButton(
            title: "Home Page",
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage(title: 'ssss',)),
            ),
          ),
        ],
      ),
    );
  }
}

InkWell inkWellButton({Function()? onTab, String? title}) {
  return InkWell(
    onTap: onTab,
    child: Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
      ),
      child: Text(
        title ?? "Submit",
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
