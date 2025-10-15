import 'package:quickWork/data/model/technicians/GetTechniciansListModel.dart';
import 'package:quickWork/domain/repository/technicians/get_technicians_list_repository.dart';

class GetTechniciansListUseCase {
  final GetTechniciansListRepository repository;

  GetTechniciansListUseCase(this.repository);

  Future<List<GetTechniciansListModel>> call() async {
    return await repository.getTechnicians();
  }
}
