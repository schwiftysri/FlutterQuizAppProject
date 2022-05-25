import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const FlutterLogo(
                  size: 150,
                ),
                Flexible(
                  child: LoginButton(
                    icon: FontAwesomeIcons.userNinja,
                    text: 'Continue as Guest',
                    loginMethod: AuthService().anonLogin,
                    color: Colors.deepPurple,
                  ),
                ),
                LoginButton(
                  icon: FontAwesomeIcons.google,
                  text: 'Sign in with Google',
                  loginMethod: AuthService().googleLogin,
                  color: Colors.blue,
                ),
                FutureBuilder<Object>(
                  future: SignInWithApple.isAvailable(),
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return SignInWithAppleButton(
                        onPressed: () {
                          AuthService().signInWithApple();
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            )));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.icon,
      required this.loginMethod})
      : super(key: key);

  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton.icon(
          icon: Icon(icon, color: Colors.white, size: 20),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: color,
          ),
          onPressed: () => loginMethod(),
          label: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ));
  }
}
