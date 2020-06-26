import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'ChatScreen.dart';

final ThemeData kIosData = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);
final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIosData
        : kDefaultTheme,
      title: 'Friendly Chat',
      home: ChatScreen(),
    );
  }
}

