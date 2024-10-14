import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dr_drink/screens/sign_up_screen.dart';
import 'package:dr_drink/widgets/welcomeWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dr_drink/values/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _loginUser() async {
    if (_emailController.text.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Email cannot be empty.',
      ).show();
      return;
    }

    if (_passwordController.text.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Password cannot be empty.',
      ).show();
      return;
    }

    String emailPattern = r'\w+@\w+\.\w+';
    if (!RegExp(emailPattern).hasMatch(_emailController.text)) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Invalid Email',
        desc: 'Please enter a valid email address.',
      ).show();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (credential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isUserRegistered', true);
        print(await prefs.getBool('isUserRegistered'));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'User Not Found',
          desc: 'No user found for that email.',
        ).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Incorrect Password',
          desc: 'Wrong password provided for that user.',
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: e.message ?? 'Login failed. Please try again.',
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    FontWeight subTextWeight = FontWeight.w400;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.14),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: MyColor.blue,
                          fontSize: screenWidth * 0.08,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Login now to track all your daily water intake ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                          fontFamily: 'Poppins',
                          fontWeight: subTextWeight,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Poppins',
                        fontWeight: subTextWeight,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      decoration: InputDecoration(
                        hintText: 'Ex: abc@example.com',
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins'),
                        prefixIcon: const Icon(
                          Icons.alternate_email,
                          color: MyColor.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                              color: MyColor.blue, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                              color: MyColor.blue, width: 1.5),
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      'Your Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Poppins',
                        fontWeight: subTextWeight,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '***********',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.lock_open_outlined,
                          color: MyColor.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                              color: MyColor.blue, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                              color: MyColor.blue, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Text('Forgot Password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: MyColor.blue,
                          decorationThickness: 1.5,
                          color: MyColor.blue,
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Poppins',
                          fontWeight: subTextWeight,
                        )),
                    SizedBox(height: screenHeight * 0.03),
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: MyColor.blue,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: _loginUser,
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: MyColor.blue,
                                minimumSize: const Size(double.infinity, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            child: const Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700)),
                          ),
                    SizedBox(height: screenHeight * 0.04),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 72, vertical: 16),
                        side: const BorderSide(color: Colors.black, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Image(
                            image: AssetImage('assets/icons/google_icon.png'),
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          const Text(
                            'Login with Google',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Center(
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: screenWidth * 0.04,
                              fontWeight: subTextWeight,
                              color: Colors.black),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: MyColor.blue,
                                decorationThickness: 1.5,
                                fontFamily: 'Poppins',
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                                color: MyColor.blue),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
