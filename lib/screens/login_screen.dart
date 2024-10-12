import 'package:flutter/material.dart';
import 'package:dr_drink/values/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FontWeight subTextWeight = FontWeight.w400;
    double containerHight = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 116,
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login ',
                    style: TextStyle(
                      color: MyColor.blue,
                      fontSize: 40,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Login now to track all your expenses and income at a place! ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: subTextWeight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        children: [Text('Continue with Google')],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
