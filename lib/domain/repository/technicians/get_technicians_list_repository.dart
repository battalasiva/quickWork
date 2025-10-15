import 'package:quickWork/data/model/technicians/GetTechniciansListModel.dart';

abstract class GetTechniciansListRepository {
  Future<List<GetTechniciansListModel>> getTechnicians();
}
