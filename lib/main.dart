import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //used as a precautionary measure as we are using async in the begining of the application
  final supabase = await Supabase.initialize(url: AppSecrets.supabase_url, anonKey: AppSecrets.supabase_anon);
  runApp(MultiBlocProvider(
    providers:[
      BlocProvider(create: (_)=>AuthBloc(userSignUp: UserSignUp(AuthRepositoryImplementation(AuthRemoteDataSourceImpl(supabase.client),),),),),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog App",
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
