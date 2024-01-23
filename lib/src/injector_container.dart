import 'package:chatapp/src/features/authentication/auth.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
Future<void> init() async {
  serviceLocator
      .registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => AuthService(repository: serviceLocator()));

  serviceLocator
      .registerFactory(() => AuthCubit(authRepository: serviceLocator()));
}
