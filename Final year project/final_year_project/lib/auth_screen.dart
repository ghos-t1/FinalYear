import 'package:flutter/material.dart';
import 'package:final_year_project/login_screen.dart';
import 'package:final_year_project/signup_screen.dart';

// Authentication screen that handles switching between login and signup
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Controls which screen is currently shown (login/signup)
  bool showLogin = true;

  // Toggle between login and signup screens with animation
  void toggleAuth() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Animated container that switches between login and signup
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: showLogin
          ? LoginScreen(
              key: ValueKey('login'),
              onSignUpTap: toggleAuth,
            )
          : SignupScreen(
              key: ValueKey('signup'),
              onLoginTap: toggleAuth,
            ),
    );
  }
}
