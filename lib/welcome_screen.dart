import 'package:flutter/material.dart';
import 'package:yellow_play/registration_screen.dart';
import 'login_screen.dart';
import 'package:yellow_play/components/roundedButton.dart';

class WelcomeScreen extends StatefulWidget {

  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this);
    animation= ColorTween(begin: Colors.amberAccent, end: Colors.blue ).animate(controller);
    controller.forward();
    controller.addListener((){
      setState(() {});

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/YP_logo.png'),
                      height: 60.0,
                    ),
                  ),
                  Text(
                   'Yellow Play',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(title: 'Log In', colour: Colors.amber, onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },),
              RoundedButton(title: 'Register', colour: Colors.amberAccent, onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },),
            ],
          ),
        ),
      ),
    );
  }
}

