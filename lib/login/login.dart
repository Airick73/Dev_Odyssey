import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dev_odyssey/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 450),
              child: const FlutterLogo(size: 150),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 100, left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: LoginButton(
                    color: Color.fromARGB(77, 86, 85, 85),
                    icon: const Icon(FontAwesomeIcons.grinTongueSquint),
                    loginMethod: AuthService().anonLogin,
                    text: const Text('Continue as a guest'),
                  ),
                ),
                Flexible(
                  child: LoginButton(
                    color: Colors.white30,
                    icon: const Icon(FontAwesomeIcons.google),
                    loginMethod: AuthService().googleLogin,
                    text: const Text('Login with Google'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final Icon icon;
  final Text text;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.loginMethod,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
        onPressed: () => loginMethod(),
        icon: icon,
        label: text,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.amber),
        ),
      ),
    );
  }
}
