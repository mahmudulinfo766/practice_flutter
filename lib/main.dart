import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:mach_managed/page_list.dart';



void main() async {
 /*  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(const MaterialApp(
    home: PageList(),
  ));
}
/*
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:mach_managed/bird_game/flappy_bird_game.dart';

void main() {
  runApp(GameWidget(game: FlappyBirdGame()));
}
*/





