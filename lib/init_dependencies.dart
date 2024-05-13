import 'package:blog_app/core/common/cubits/app_cubits/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_implementation.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/network/connection_checker.dart';
import 'core/secrets/app_secrets.dart';
import 'features/blog/data/datasources/blog_remote_data_source.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  //Authentication :
  _initAuth();
  //Blog :
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabase_url, anonKey: AppSecrets.supabase_anon);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  //Whenever we use that type, a new object is created and returned.
  // serviceLocator.registerFactory(() => null);

  //used when you want to create a single instance and store it in the memory, and whenever you call it -> it gives you the same instance.
  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(
        () => Hive.box(name: 'blogs'),
  );

  serviceLocator.registerFactory(() => InternetConnection());

  //core:
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
        () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  //DATA SOURCE
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()))

    //REPOSITORY
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImplementation(serviceLocator(), serviceLocator()))

    //USECASE
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))

    //BLOC
    ..registerLazySingleton(() =>
        AuthBloc(userSignUp: serviceLocator(), userLogIn: serviceLocator(), currentUser: serviceLocator(), appUserCubit: serviceLocator()));
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
          () =>
          BlogRemoteDataSourceImpl(
            serviceLocator(),
          ),
    )
  ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(
      serviceLocator(),
    ),
  )
  // Repository
    ..registerFactory<BlogRepository>(
          () =>
          BlogRepositoryImplementation(
            serviceLocator(),
            serviceLocator(),
            serviceLocator(),
          ),
    )
  // Usecases
    ..registerFactory(
          () =>
          UploadBlog(
            serviceLocator(),
          ),
    )
  ..registerFactory(
        () => GetAllBlogs(
      serviceLocator(),
    ),
  )
  // Bloc
    ..registerLazySingleton(
          () =>
          BlogBloc(
            uploadBlog: serviceLocator(),
            getAllBlogs: serviceLocator(),
          ),
    );
}