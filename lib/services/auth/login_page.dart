import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instamessenger/services/auth/auth_services.dart';

import '../../widgets/auth_textfiled.dart';
import '../../widgets/button.dart';
import '../../widgets/divider.dart';
import '../../widgets/facebook_login_button.dart';
import '../../widgets/richtext_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.signup});
  final void Function() signup;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  //user log in
  void login() async {
    setState(() {
      isLoading = !isLoading;
    });
    
    final AuthServices auth = AuthServices();
    try {
       await auth.logInUser(emailController.text, passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously, prefer_const_constructors
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong. Please check your credentials'),),);
    }
     setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    
     double h = MediaQuery.of(context).size.height * 0.20;

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
                  padding: const EdgeInsets.only(bottom: 26),
                  child: SvgPicture.asset(
                    'assets/images/ic_instagram.svg',
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    height: 64,
                  ),
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

                const SizedBox(
                  height: 3,
                ),

                //login button
                if(!isLoading)
                Button(
                  onTap: login,
                  text: 'Log In',
                 
                ),
                if(isLoading)
                const CircularProgressIndicator(),

                //rich text -> forgot password

                RichTextButton(
                  onTap: () {},
                  firstText: 'Forgot your login details?',
                  secondText: ' Get help with logging in.',
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
                firstText: 'Dont have an account?',
                secondText: ' Sign up.',
                onTap: widget.signup,
              )
            ],
          ),
        ],
      ),
    );
  }
}
