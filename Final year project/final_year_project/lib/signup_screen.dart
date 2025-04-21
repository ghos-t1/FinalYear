import 'package:animate_do/animate_do.dart';
import 'package:final_year_project/custom_button.dart';
import 'package:final_year_project/custom_field.dart';
import 'package:final_year_project/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final GestureTapCallback onLoginTap;
  const SignupScreen({Key? key, required this.onLoginTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f9fd),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              FadeInDown(
                duration: Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff4a154b).withAlpha(26),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(' Join Us today',
                          style: TextStyle(
                            color: Color(0xff4a154b),
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Create your\naccount',
                      style: TextStyle(
                        color: Color(0xff1d1c1d),
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 200),
                child: Column(
                  children: [
                    CustomTextField(
                      icon: CupertinoIcons.mail,
                      hint: 'Email',
                      gradientColours: [Color(0xff4a154b), Color(0xff6b1a6b)],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      icon: CupertinoIcons.person,
                      hint: 'Username',
                      gradientColours: [Color(0xff4a154b), Color(0xff6b1a6b)],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      icon: CupertinoIcons.lock,
                      hint: 'Password',
                      isPassword: true,
                      gradientColours: [Color(0xff4a154b), Color(0xff6b1a6b)],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      icon: CupertinoIcons.lock,
                      hint: 'Confirm Password',
                      isPassword: true,
                      gradientColours: [Color(0xff4a154b), Color(0xff6b1a6b)],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 400),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  text: 'Sign Up',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xff1d1c1d)),
                    ),
                    GestureDetector(
                      onTap: onLoginTap,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff4a154b),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  // ignore: unused_element
  Widget _buildSocialButton(
      {required IconData icon,
      required String label,
      required List<Color> gradientColors}) {
    return Container(
      height: 55,
      width: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradientColors[0].withAlpha(26),
            gradientColors[1].withAlpha(26),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: gradientColors[0].withAlpha(26)),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: gradientColors[0].withAlpha(26),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
