import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/widgets/welcomeWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w700,
                          color: MyColor.blue,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Create an ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Poppins',
                              fontWeight: subTextWeight,
                            ),
                          ),
                          TextSpan(
                            text: 'account ',
                            style: TextStyle(
                              color: MyColor.blue,
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'to access all the features of ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Poppins',
                              fontWeight: subTextWeight,
                            ),
                          ),
                          TextSpan(
                            text: 'Drink Daily!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      _buildTextField(
                        'Email',
                        'Ex: abc@example.com',
                        _emailController,
                        Icons.alternate_email,
                        TextInputType.emailAddress,
                        _emailFocusNode,
                        nextFocusNode: _nameFocusNode,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      _buildTextField(
                        'Your Name',
                        'Ex. James Bond',
                        _nameController,
                        Icons.person_outline,
                        TextInputType.name,
                        _nameFocusNode,
                        nextFocusNode: _passwordFocusNode,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      _buildTextField(
                        'Your Password',
                        '***************',
                        _passwordController,
                        Icons.lock_open_outlined,
                        TextInputType.visiblePassword,
                        _passwordFocusNode,
                        obscureText: true,
                        isPasswordField: true, // Enable password field logic
                      ),
                      SizedBox(height: screenHeight * 0.06),

                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: MyColor.blue,
                            ))
                          : ElevatedButton(
                              onPressed: _registerUser,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 60),
                                backgroundColor: MyColor.blue,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                      SizedBox(height: screenHeight * 0.05),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: screenWidth * 0.04,
                                fontWeight: subTextWeight,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: MyColor.blue,
                                  decorationThickness: 1.5,
                                  fontFamily: 'Poppins',
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: MyColor.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _registerUser() async {
    if (_emailController.text.isEmpty) {
      _showErrorDialog('Error', 'Email cannot be empty.');
      return;
    }
    if (_nameController.text.isEmpty) {
      _showErrorDialog('Error', 'Name cannot be empty.');
      return;
    }
    if (_passwordController.text.isEmpty) {
      _showErrorDialog('Error', 'Password cannot be empty.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await credential.user?.sendEmailVerification(); // Send verification email

      // Show the waiting dialog while checking for verification
      _showWaitingDialog(credential.user!);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (e.code == 'weak-password') {
        _showErrorDialog('Weak Password', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showErrorDialog('Email Already In Use',
            'The account already exists for that email.');
      } else {
        _showErrorDialog('Sign Up Failed',
            e.message ?? 'An error occurred while signing up.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      _showErrorDialog('Sign Up Failed',
          'An error occurred while signing up. Please try again.');
    }
  }

  void _showWaitingDialog(User user) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog manually
      builder: (context) {
        return const AlertDialog(
          title: Text('Waiting for Verification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                'Please verify your email by clicking the link sent to your inbox.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'This may take a few moments...',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );

    // Start checking if the email is verified every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await user.reload(); // Refresh user state
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        timer.cancel(); // Stop the timer

        // Update the user's display name using the value from _nameController
        String newName = _nameController.text;
        await currentUser.updateDisplayName(newName);
        await currentUser.reload(); // Ensure the update takes effect

        Navigator.pop(context); // Close the dialog

        // Navigate to the next page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()), // Replace with your main page
        );
      }
    });
  }


  void _showErrorDialog(String title, String description) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
    ).show();
  }

  Widget _buildTextField(
      String label,
      String hint,
      TextEditingController controller,
      IconData icon,
      TextInputType inputType,
      FocusNode focusNode, {
        bool obscureText = false,
        FocusNode? nextFocusNode,
        bool isPasswordField = false, // New flag to detect password field
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.006),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          focusNode: focusNode,
          obscureText: isPasswordField ? !_isPasswordVisible : obscureText,
          onFieldSubmitted: (_) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(icon, color: MyColor.blue),
            suffixIcon: isPasswordField
                ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: MyColor.blue,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: MyColor.blue,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: MyColor.blue,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
