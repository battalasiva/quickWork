import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:quickWork/core/network/dio_client.dart';
import 'package:quickWork/core/network/network_service.dart';
import 'package:quickWork/data/datasource/auth/current_customer_remote_data_source.dart';
import 'package:quickWork/data/datasource/auth/signin_remote_data_source.dart';
import 'package:quickWork/data/datasource/auth/trigger_otp_remote_data_source.dart';
import 'package:quickWork/data/datasource/technicians/RaiseTechnicianRequestRemoteDataSource.dart';
import 'package:quickWork/data/datasource/technicians/approve_technician_remote_data_source.dart';
import 'package:quickWork/data/datasource/technicians/delete_technician_remote_data_source.dart';
import 'package:quickWork/data/datasource/work-category/delete_work_category_remote_data_source.dart';
import 'package:quickWork/data/datasource/work-category/get_work_categories_remote_data_source.dart';
import 'package:quickWork/data/datasource/work-category/post_work_type_remote_data_source.dart';
import 'package:quickWork/data/datasource/work-request/work_request_remote_data_source.dart';
import 'package:quickWork/domain/repository-impl/auth/current_customer_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/auth/signin_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/auth/trigger_otp_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/technicians/RaiseTechnicianRequestRepositoryImpl.dart';
import 'package:quickWork/domain/repository-impl/technicians/approve_technician_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/technicians/delete_technician_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/work-category/delete_work_category_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/work-category/get_work_categories_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/work-category/post_work_type_repository_impl.dart';
import 'package:quickWork/domain/repository-impl/work-request/work_request_repository_impl.dart';
import 'package:quickWork/domain/repository/auth/current_customer_repository.dart';
import 'package:quickWork/domain/repository/technicians/RaiseTechnicianRequestRepository.dart';
import 'package:quickWork/domain/repository/technicians/approve_technician_repository.dart';
import 'package:quickWork/domain/repository/technicians/delete_technician_repository.dart';
import 'package:quickWork/domain/repository/work-category/delete_work_category_repository.dart';
import 'package:quickWork/domain/repository/work-category/get_work_categories_repository.dart';
import 'package:quickWork/domain/repository/work-category/post_work_type_repository.dart';
import 'package:quickWork/domain/repository/work-request/work_request_repository.dart';
import 'package:quickWork/domain/usecase/auth/current_customer_usecase.dart';
import 'package:quickWork/domain/usecase/auth/signin_usecase.dart';
import 'package:quickWork/domain/usecase/auth/trigger_otp_usecase.dart';
import 'package:quickWork/domain/usecase/technicians/RaiseTechnicianRequestUseCase.dart';
import 'package:quickWork/domain/usecase/technicians/approve_technician_usecase.dart';
import 'package:quickWork/domain/usecase/technicians/delete_technician_usecase.dart';
import 'package:quickWork/domain/usecase/work-category/delete_work_category_usecase.dart';
import 'package:quickWork/domain/usecase/work-category/get_work_categories_usecase.dart';
import 'package:quickWork/domain/usecase/work-category/post_work_type_usecase.dart';
import 'package:quickWork/domain/usecase/work-request/create_work_request_usecase.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/signin/sigin_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/trigger-otp/trigger_otp_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/approve-technician/approve_technician_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/delete-Technician/delete_technician_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/raise-technician-request/RaiseTechnicianRequestCubit.dart';
import 'package:quickWork/presentations/cubit/work-category/delete-work-category/delete_work_category_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/post-work/post_work_type_cubit.dart';
import 'package:quickWork/presentations/cubit/work-request/post-work-request/work_request_cubit.dart';

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

  //post work type
  sl.registerLazySingleton<PostWorkTypeRemoteDataSourceImpl>(
    () => PostWorkTypeRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<PostWorkTypeRepository>(
    () => PostWorkTypeRepositoryImpl(
      remoteDataSource: sl<PostWorkTypeRemoteDataSourceImpl>(),
    ),
  );

  sl.registerLazySingleton(
    () => PostWorkTypeUseCase(sl<PostWorkTypeRepository>()),
  );

  sl.registerFactory(
    () => PostWorkTypeCubit(sl<PostWorkTypeUseCase>(), sl<NetworkService>()),
  );

  // Get work GetWorkCategories
  sl.registerLazySingleton<GetWorkCategoriesRemoteDataSourceImpl>(
    () => GetWorkCategoriesRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<GetWorkCategoriesRepository>(
    () => GetWorkCategoriesRepositoryImpl(
      remoteDataSource: sl<GetWorkCategoriesRemoteDataSourceImpl>(),
    ),
  );

  sl.registerLazySingleton(
    () => GetWorkCategoriesUseCase(sl<GetWorkCategoriesRepository>()),
  );

  sl.registerFactory(
    () => GetWorkCategoriesCubit(
      sl<GetWorkCategoriesUseCase>(),
      sl<NetworkService>(),
    ),
  );

  //Delete work category
  sl.registerLazySingleton<DeleteWorkCategoryRemoteDataSourceImpl>(
    () => DeleteWorkCategoryRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<DeleteWorkCategoryRepository>(
    () => DeleteWorkCategoryRepositoryImpl(
      remoteDataSource: sl<DeleteWorkCategoryRemoteDataSourceImpl>(),
    ),
  );

  sl.registerLazySingleton(
    () => DeleteWorkCategoryUseCase(sl<DeleteWorkCategoryRepository>()),
  );

  sl.registerFactory(
    () => DeleteWorkCategoryCubit(
      sl<DeleteWorkCategoryUseCase>(),
      sl<NetworkService>(),
    ),
  );

  //post work request
  sl.registerLazySingleton<WorkRequestRemoteDataSourceImpl>(
    () => WorkRequestRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<WorkRequestRepository>(
    () => WorkRequestRepositoryImpl(
      remoteDataSource: sl<WorkRequestRemoteDataSourceImpl>(),
    ),
  );

  sl.registerLazySingleton(
    () => CreateWorkRequestUseCase(sl<WorkRequestRepository>()),
  );

  sl.registerFactory(
    () =>
        WorkRequestCubit(sl<CreateWorkRequestUseCase>(), sl<NetworkService>()),
  );

  //Raise Technician Request
  // inside injection_container.dart or wherever you register dependencies

  sl.registerLazySingleton<RaiseTechnicianRequestRemoteDataSource>(
    () =>
        RaiseTechnicianRequestRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<RaiseTechnicianRequestRepository>(
    () => RaiseTechnicianRequestRepositoryImpl(
      remoteDataSource: sl<RaiseTechnicianRequestRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton(
    () => RaiseTechnicianRequestUseCase(sl<RaiseTechnicianRequestRepository>()),
  );

  sl.registerFactory(
    () => RaiseTechnicianRequestCubit(
      sl<RaiseTechnicianRequestUseCase>(),
      sl<NetworkService>(),
    ),
  );
  //delete Technician
  sl.registerLazySingleton<DeleteTechnicianRemoteDataSourceImpl>(
    () => DeleteTechnicianRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<DeleteTechnicianRepository>(
    () => DeleteTechnicianRepositoryImpl(
      remoteDataSource: sl<DeleteTechnicianRemoteDataSourceImpl>(),
    ),
  );

  sl.registerLazySingleton(
    () => DeleteTechnicianUseCase(sl<DeleteTechnicianRepository>()),
  );

  sl.registerFactory(
    () => DeleteTechnicianCubit(
      sl<DeleteTechnicianUseCase>(),
      sl<NetworkService>(),
    ),
  );
  //Approve Technician
  // DataSource
  sl.registerLazySingleton<ApproveTechnicianRemoteDataSourceImpl>(
    () => ApproveTechnicianRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  // Repository
  sl.registerLazySingleton<ApproveTechnicianRepository>(
    () => ApproveTechnicianRepositoryImpl(
      remoteDataSource: sl<ApproveTechnicianRemoteDataSourceImpl>(),
    ),
  );

  // UseCase
  sl.registerLazySingleton(
    () => ApproveTechnicianUseCase(sl<ApproveTechnicianRepository>()),
  );

  // Cubit
  sl.registerFactory(
    () => ApproveTechnicianCubit(
      sl<ApproveTechnicianUseCase>(),
      sl<NetworkService>(),
    ),
  );
}
