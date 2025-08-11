import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:quickWork/core/network/dio_client.dart';
import 'package:quickWork/core/network/network_service.dart';
import 'package:quickWork/data/datasource/auth/current_customer_remote_data_source.dart';
import 'package:quickWork/data/datasource/auth/signin_remote_data_source.dart';
import 'package:quickWork/data/datasource/auth/trigger_otp_remote_data_source.dart';
import 'package:quickWork/domain/repository-impl/auth/current_customer_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/auth/signin_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/auth/trigger_otp_repository_impl.dart';
import 'package:quickWork/domain/repository/auth/current_customer_repository.dart';
import 'package:quickWork/domain/usecase/auth/current_customer_usecase.dart';
import 'package:quickWork/domain/usecase/auth/signin_usecase.dart';
import 'package:quickWork/domain/usecase/auth/trigger_otp_usecase.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/signin/sigin_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/trigger-otp/trigger_otp_cubit.dart';

final GetIt sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => NetworkService());
  sl.registerLazySingleton<DioClient>(
    () => DioClient(sl<Dio>(), secureStorage: sl<FlutterSecureStorage>()),
  );
  //trigger Otp
  sl.registerLazySingleton<TriggerOtpRemoteDataSource>(
    () => TriggerOtpRemoteDataSourceImpl(client: sl<Dio>()),
  );
  sl.registerLazySingleton(
    () => TriggerOtpRepositoryImpl(
      remoteDataSource: sl<TriggerOtpRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton(
    () =>
        TriggerOtpValidationUseCase(repository: sl<TriggerOtpRepositoryImpl>()),
  );
  sl.registerFactory(
    () => TriggerOtpCubit(
      useCase: sl<TriggerOtpValidationUseCase>(),
      networkService: sl<NetworkService>(),
    ),
  );
  //signin
  sl.registerLazySingleton<SignInRemoteDataSource>(
    () => SignInRemoteDataSourceImpl(client: sl<Dio>()),
  );
  sl.registerLazySingleton(
    () => SignInRepositoryImpl(remoteDataSource: sl<SignInRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => SignInValidationUseCase(repository: sl<SignInRepositoryImpl>()),
  );
  sl.registerFactory(() => SignInCubit(useCase: sl<SignInValidationUseCase>()));

  //current-customer
  sl.registerLazySingleton<CurrentCustomerRemoteDataSourceImpl>(
    () => CurrentCustomerRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<CurrentCustomerRepository>(
    () => CurrentCustomerRepositoryImpl(
      remoteDataSource: sl<CurrentCustomerRemoteDataSourceImpl>(),
    ),
  );

  sl.registerLazySingleton(
    () => CurrentCustomerUseCase(sl<CurrentCustomerRepository>()),
  );

  sl.registerFactory(
    () => CurrentCustomerCubit(
      sl<CurrentCustomerUseCase>(),
      sl<NetworkService>(),
    ),
  );
}
