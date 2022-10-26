
import 'package:bkapp/domain/models/user_model.dart';
import 'package:bkapp/domain/service/mock/mock_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  test('Fetch Users', () async {
    final mockService = MockService();
    final response = await mockService.fetchUsers();

    expect(response is List<User>, true);
  });
}