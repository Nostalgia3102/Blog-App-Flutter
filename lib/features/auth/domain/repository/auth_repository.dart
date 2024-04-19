import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';


//Diff b/w -> Abstract Class & Abstract Interface Class is that interface class forces to implement the abstract methods.
abstract interface class AuthRepository{
  //Here, we are going to define 2 methods :
  //Login with email and pwd & SignUp with email and pwd
  //These methods will give only 2 output: Either a SUCCESS or FAILURE :
  // Hence, We are going to implement this using package: fpdart imported from pub.dev

  //Making a new user defined data structure (class - failure) to tackle the error/ failure messages :
  //Lastly we wrapped the return type in Future because this is going to be a async process
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,}
  );

  Future<Either<Failure, String>> logInWithEmailPassword({
    required String email,
    required String password,}
  );
}