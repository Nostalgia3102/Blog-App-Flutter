import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required name,
    required email,
    required password
  });

  Future<String> logInWithEmailPassword({
    required email,
    required password
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final SupabaseClient supabaseClient; //why hav'nt we initialized it here like final abc = Abc(one:..., two:...) ?
  //-> Due to two reasons:
  //1) We will do dependency injection, so that it becomes easy to change in to a different DB in near future.
  //2) It makes testing easy on our application.

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> logInWithEmailPassword({required email, required password}) {
    // TODO: implement logInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({required name, required email, required password}) async{
    try{
      final response = await supabaseClient.auth.signUp(
          email: email,
          password: password,
          data: {
            "name": name
          });
      if(response.user == null){
        throw ServerException("User is Null");
      }
      return response.user!.id;
    }catch(e){
        throw ServerException(e.toString());
    }
  }

}