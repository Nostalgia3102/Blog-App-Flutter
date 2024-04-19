import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {

  static router() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController= TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Text("Sign Up.", style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold, color: Colors.white),),
              const SizedBox(height: 20,),
               AuthField(hintText: "Name",controller: nameController,),
              const SizedBox(height: 20,),
              AuthField(hintText: "Email",controller: emailController,),
              const SizedBox(height: 20,),
              AuthField(hintText: "Password",controller: passwordController,isObscureText: true,),
              const SizedBox(height: 30,),
              AuthGradientButton(text: "Sign In", onPressed: (){
                if(formKey.currentState!.validate()){
                  context.read<AuthBloc>().add(
                      AuthSignUp(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()
                      ));
                }
              },),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, LoginPage.router());
                },
                child: RichText(text: TextSpan(text: "Already have an Account ?  ", style: Theme.of(context).textTheme.bodyMedium, children: [
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
