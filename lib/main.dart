
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yellow_play/video_screen.dart';
import 'package:yellow_play/welcome_screen.dart';
import 'package:yellow_play/login_screen.dart';
import 'package:yellow_play/registration_screen.dart';

void main() => runApp(YellowPlay());

class YellowPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id : (context) => WelcomeScreen(),
          LoginScreen.id : (context) => LoginScreen(),
          RegistrationScreen.id : (context) => RegistrationScreen(),
          VideoScreen.id : (context) => VideoScreen(),
        },

        home: WelcomeScreen(),
      ),
    );
  }
}
