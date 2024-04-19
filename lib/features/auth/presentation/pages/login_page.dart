import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static router() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final emailController= TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // formKey.currentState!.validate();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign In.", style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold, color: Colors.white),),
              const SizedBox(height: 20,),
              AuthField(hintText: "Email",controller: emailController,),
              const SizedBox(height: 20,),
              AuthField(hintText: "Password",controller: passwordController,isObscureText: true,),
              const SizedBox(height: 30,),
              AuthGradientButton(text: "Log In",onPressed: (){},),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, SignUpPage.router());
                },
                child: RichText(text: TextSpan(text: "Don't have an Account ?  ", style: Theme.of(context).textTheme.bodyMedium, children: [
                  TextSpan(text: 'Sign In', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppPalette.gradient2
                  ))
                ]),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
