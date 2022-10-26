import 'package:bkapp/domain/models/user_model.dart';
import 'package:bkapp/domain/service/mock/mock_service.dart';


class MockApiRepository {
  MockApiRepository(this._mockService);
  final MockService _mockService;

// Repository Function for fecthing data from api 
  Future<List<User>?> fetchData()async{
    return await _mockService.fetchUsers();
  }
}
