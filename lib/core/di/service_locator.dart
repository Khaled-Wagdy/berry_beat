import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/forget_password/cubit/forget_password_cubit.dart';
import '../../features/forget_password/data/repo/forget_password_repo.dart';
import '../../features/home/cubit/home_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Dio instance
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt<Dio>()));
  getIt.registerLazySingleton<ForgetPasswordRepo>(
    () => ForgetPasswordRepo(getIt<Dio>()),
  );
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt<Dio>()));

  // Cubits / ViewModels
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt<ForgetPasswordRepo>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
}
