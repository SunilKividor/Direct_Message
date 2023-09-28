// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instamessenger/services/auth/auth_services.dart';
import 'package:instamessenger/widgets/auth_textfiled.dart';
import 'package:instamessenger/widgets/button.dart';
import 'package:instamessenger/widgets/divider.dart';
import 'package:instamessenger/widgets/facebook_login_button.dart';
import 'package:instamessenger/widgets/image_picker.dart';
import 'package:instamessenger/widgets/richtext_button.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key, required this.login});

  final void Function() login;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController userNameController =
      TextEditingController();    

  File? pickedImage;
  bool isLoading = false;

  void signUp() async {
    setState(() {
      isLoading = !isLoading;
    });

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password do not match. Try again!'),
        ),
      );
      return;
    }
    if(userNameController.text.trim().isEmpty || emailController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter username and email!'),
        ),
      );
      return;
    }
    if (pickedImage == null) return;

    final AuthServices auth = AuthServices();
    try {
      await auth.createUser(
          emailController.text, passwordController.text, pickedImage!,userNameController.text);
    } catch (e) {
    
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Try again!')));
    }
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height * 0.094;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: h),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SvgPicture.asset(
                    'assets/images/ic_instagram.svg',
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    height: 64,
                  ),
                ),

                ImagePick(
                  onPickImage: (onpickedImage) {
                    pickedImage = onpickedImage;
                  },
                ),

                //user name field
                AuthTextField(
                  controller: userNameController,
                  hintText: 'username',
                  isPass: false,
                ),

                //email text field
                AuthTextField(
                  controller: emailController,
                  hintText: 'email address',
                  isPass: false,
                ),

                const SizedBox(
                  height: 2,
                ),

                //password text field
                AuthTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isPass: true,
                ),
                AuthTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  isPass: true,
                ),

                const SizedBox(
                  height: 3,
                ),

                //login button
                if (!isLoading)
                  Button(
                    onTap: signUp,
                    text: 'Sign Up',
                  ),
                if (isLoading) const CircularProgressIndicator(),

                const SizedBox(
                  height: 8,
                ),

                //divider
                const Divide(),

                //facebook login button
                FaceBookLoginButton(
                  onTap: () {},
                ),

                //sizedbox
                SizedBox(
                  height: h,
                ),
              ],
            ),
          ),

          //divider
          Column(
            children: [
              const Divider(
                color: Colors.grey,
              ),

              //sign up option
              RichTextButton(
                firstText: 'Already have an account?',
                secondText: ' Log In.',
                onTap: widget.login,
              )
            ],
          ),
        ],
      ),
    );
  }
}
