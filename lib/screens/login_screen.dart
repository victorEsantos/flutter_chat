import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/main_screen.dart';
import 'package:flutter_chat/widgets/rounded_button.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  var erorTxt = '...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: 'Senha'),
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Login',
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                  Navigator.pushNamed(context, MainScreen.id);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    setState(() => erorTxt = 'No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    setState(() =>
                        erorTxt = 'Wrong password provided for that user.');
                  }
                }
              },
              color: kAppDefaultMainCOlor,
            ),
            Center(
              child: Text(
                erorTxt,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
