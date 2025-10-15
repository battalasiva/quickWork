import 'package:quickWork/data/datasource/technicians/get_technicians_list_remote_data_source.dart';
import 'package:quickWork/data/model/technicians/GetTechniciansListModel.dart';
import 'package:quickWork/domain/repository/technicians/get_technicians_list_repository.dart';

class GetTechniciansListRepositoryImpl implements GetTechniciansListRepository {
  final GetTechniciansListRemoteDataSource remoteDataSource;

  GetTechniciansListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<GetTechniciansListModel>> getTechnicians() async {
    return await remoteDataSource.fetchTechnicians();
  }
}
