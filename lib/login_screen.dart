import 'package:flutter/material.dart';
import 'package:yellow_play/components/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yellow_play/video_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/YP_logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                     email=value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.amberAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.amberAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password=value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your password.',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.amberAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.amberAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(title: 'Log In', colour: Colors.amberAccent,
                    onPressed: () async {
                    setState(() {
                      showSpinner=true;
                    });
                    try {
                      final user = _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, VideoScreen.id);
                      }
                      setState(() {
                        showSpinner=false;
                      });
                    }
                    catch (e){
                      print(e);
                    }
                  },),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
